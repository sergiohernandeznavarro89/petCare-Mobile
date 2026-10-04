import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../pets/presentation/pets_provider.dart';
import '../../pets/presentation/widgets/horizontal_pet_card.dart';
import 'health_providers.dart';
import '../domain/health_event_dto.dart';
import 'widgets/event_speed_dial.dart';
import 'add_health_event_bottom_sheet.dart';
import '../data/health_repository.dart';

class HealthTimelineScreen extends ConsumerStatefulWidget {
  const HealthTimelineScreen({super.key});

  @override
  ConsumerState<HealthTimelineScreen> createState() => _HealthTimelineScreenState();
}

class _HealthTimelineScreenState extends ConsumerState<HealthTimelineScreen> {
  int _itemsToShow = 10;

  @override
  Widget build(BuildContext context) {
    final petsAsync = ref.watch(petsProvider);
    final selectedPet = ref.watch(effectivePetProvider);
    final theme = Theme.of(context);

    final historyAsync = selectedPet != null ? ref.watch(healthHistoryProvider(selectedPet.id)) : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPet == null ? 'Historial Clínico' : 'Historial de ${selectedPet.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: const EventSpeedDial(),
      body: Column(
        children: [
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: petsAsync.when(
              data: (pets) {
                if (pets.isEmpty) {
                  return const Center(child: Text('No hay mascotas.'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: pets.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final pet = pets[index];
                    final isSelected = selectedPet?.id == pet.id;
                    return HorizontalPetCard(
                      pet: pet,
                      isSelected: isSelected,
                      onTap: () {
                        if (isSelected) {
                          ref.read(selectedPetProvider.notifier).select(null);
                        } else {
                          ref.read(selectedPetProvider.notifier).toggle(pet);
                        }
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: selectedPet == null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.pets, size: 64, color: theme.colorScheme.primary.withAlpha(128)),
                          const SizedBox(height: 16),
                          Text(
                            'Selecciona una mascota arriba para ver su historial.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                  )
                : historyAsync!.when(
                    data: (events) {
                      if (events.isEmpty) {
                        return const Center(child: Text('No hay registros en el historial.'));
                      }
                      final parentEventsAll = events.where((e) {
                        return e.map(
                          vetVisit: (v) => v.parentId == null,
                          medication: (m) => m.parentId == null,
                          vaccine: (v) => v.parentId == null,
                          custom: (c) => c.parentId == null,
                        );
                      }).toList();

                      final parentEvents = parentEventsAll.take(_itemsToShow).toList();
                      final hasMoreToDisplay = parentEventsAll.length > _itemsToShow || ref.read(healthHistoryProvider(selectedPet.id).notifier).hasMore;

                      final groupedEvents = <DateTime, List<HealthEventDto>>{};
                      for (var event in parentEvents) {
                        final localDate = event.date.toLocal();
                        final date = DateTime(localDate.year, localDate.month, localDate.day);
                        if (!groupedEvents.containsKey(date)) {
                          groupedEvents[date] = [];
                        }
                        groupedEvents[date]!.add(event);
                      }
                      
                      final sortedDates = groupedEvents.keys.toList()..sort((a, b) => b.compareTo(a));

                      return RefreshIndicator(
                        onRefresh: () async => ref.invalidate(healthHistoryProvider(selectedPet.id)),
                        child: CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            for (final date in sortedDates)
                              SliverMainAxisGroup(
                                slivers: [
                                  SliverPersistentHeader(
                                    pinned: true,
                                    delegate: _StickyDateHeaderDelegate(
                                      date: date,
                                      theme: theme,
                                    ),
                                  ),
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        final parentEvent = groupedEvents[date]![index];
                                        
                                        // Recursively collect all descendants for this parent event
                                        final descendants = <HealthEventDto>[];
                                        final queue = [parentEvent.id];
                                        final realParentTitleMap = <String, String>{};
                                        
                                        while (queue.isNotEmpty) {
                                          final currentId = queue.removeAt(0);
                                          final currentTitle = currentId == parentEvent.id 
                                              ? parentEvent.title 
                                              : events.firstWhere((e) => e.id == currentId, orElse: () => parentEvent).title;

                                          final directChildren = events.where((e) {
                                            return e.map(
                                              vetVisit: (v) => v.parentId == currentId,
                                              medication: (m) => m.parentId == currentId,
                                              vaccine: (v) => v.parentId == currentId,
                                              custom: (c) => c.parentId == currentId,
                                            );
                                          }).toList();
                                          
                                          for (var child in directChildren) {
                                            if (currentId != parentEvent.id) {
                                              realParentTitleMap[child.id] = currentTitle;
                                            }
                                          }
                                          
                                          descendants.addAll(directChildren);
                                          queue.addAll(directChildren.map((c) => c.id));
                                        }
                                        
                                        // Sort descendants by date
                                        descendants.sort((a, b) => a.date.compareTo(b.date));
                                        
                                        return _buildEventCard(context, ref, parentEvent, descendants, realParentTitleMap, theme);
                                      },
                                      childCount: groupedEvents[date]!.length,
                                    ),
                                  ),
                                ],
                              ),
                            if (hasMoreToDisplay)
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        _itemsToShow += 10;
                                      });
                                      ref.read(healthHistoryProvider(selectedPet.id).notifier).fetchNextPage();
                                    },
                                    icon: const Icon(Icons.expand_more),
                                    label: const Text('Ver más'),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, _) => Center(child: Text('Error: $error', style: const TextStyle(color: Colors.red))),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, WidgetRef ref, HealthEventDto event, List<HealthEventDto> children, Map<String, String> realParentTitles, ThemeData theme) {
    return _EventCardWidget(event: event, children: children, realParentTitles: realParentTitles, theme: theme, ref: ref);
  }
}

class _EventCardWidget extends StatefulWidget {
  final HealthEventDto event;
  final List<HealthEventDto> children;
  final Map<String, String> realParentTitles;
  final ThemeData theme;
  final WidgetRef ref;

  const _EventCardWidget({
    required this.event,
    required this.children,
    required this.realParentTitles,
    required this.theme,
    required this.ref,
  });

  @override
  State<_EventCardWidget> createState() => _EventCardWidgetState();
}

class _EventCardWidgetState extends State<_EventCardWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    IconData icon = Icons.event;
    Color color = widget.theme.colorScheme.primary;

    widget.event.mapOrNull(
      vetVisit: (_) { icon = Icons.local_hospital; color = Colors.blue; },
      medication: (_) { icon = Icons.medication; color = Colors.orange; },
      vaccine: (_) { icon = Icons.vaccines; color = Colors.red; },
      custom: (_) { icon = Icons.star; color = Colors.purple; },
    );

    final cardContent = ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withAlpha(51),
        child: Icon(icon, color: color),
      ),
      title: Text(widget.event.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat('HH:mm').format(widget.event.date.toLocal())),
          if (widget.event.notes != null && widget.event.notes!.isNotEmpty)
            Text(widget.event.notes!, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.visibility, color: Colors.grey),
            onPressed: () => _showEventDetails(context, widget.event),
          ),
          if (widget.children.isNotEmpty)
            Icon(_isExpanded ? Icons.expand_less : Icons.expand_more, color: Colors.grey.shade600),
        ],
      ),
      onTap: widget.children.isNotEmpty
          ? () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            }
          : null,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Dismissible(
          key: ValueKey(widget.event.id),
          direction: DismissDirection.horizontal,
          background: Container(
            color: Colors.blue,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.edit, color: Colors.white),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              // Edit
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (ctx) => AddHealthEventBottomSheet(
                  petId: widget.ref.read(effectivePetProvider)!.id,
                  existingEvent: widget.event,
                ),
              );
              return false;
            } else {
              // Delete
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Eliminar evento'),
                  content: const Text('¿Estás seguro de que deseas eliminar este evento?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child: const Text('Cancelar'),
                    ),
                    FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () => Navigator.of(ctx).pop(true),
                      child: const Text('Eliminar'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                final repo = widget.ref.read(healthRepositoryProvider);
                await repo.deleteHealthEvent(widget.ref.read(effectivePetProvider)!.id, widget.event.id);
                widget.ref.invalidate(healthAgendaProvider);
                widget.ref.invalidate(healthHistoryProvider(widget.ref.read(effectivePetProvider)!.id));
              }
              return false;
            }
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: cardContent,
          ),
        ),
        if (widget.children.isNotEmpty)
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _isExpanded
                ? Column(
                    children: widget.children.map((child) => _buildChildEvent(child, widget.theme, widget.realParentTitles[child.id])).toList(),
                  )
                : const SizedBox.shrink(),
          ),
      ],
    );
  }

  Widget _buildChildEvent(HealthEventDto child, ThemeData theme, String? realParentTitle) {
    IconData icon = Icons.event;
    Color color = theme.colorScheme.secondary;
    child.mapOrNull(
      vetVisit: (_) { icon = Icons.local_hospital; color = Colors.blue; },
      medication: (_) { icon = Icons.medication; color = Colors.orange; },
      vaccine: (_) { icon = Icons.vaccines; color = Colors.red; },
      custom: (_) { icon = Icons.star; color = Colors.purple; },
    );

    return Padding(
      padding: const EdgeInsets.only(left: 56.0, right: 20.0, bottom: 8.0),
      child: Dismissible(
        key: ValueKey(child.id),
        direction: DismissDirection.horizontal,
        background: Container(
          color: Colors.blue,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.edit, color: Colors.white),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (ctx) => AddHealthEventBottomSheet(
                petId: widget.ref.read(effectivePetProvider)!.id,
                existingEvent: child,
              ),
            );
            return false;
          } else {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Eliminar evento'),
                content: const Text('¿Estás seguro de que deseas eliminar este evento?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: const Text('Cancelar'),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: const Text('Eliminar'),
                  ),
                ],
              ),
            );
            if (confirm == true) {
              final repo = widget.ref.read(healthRepositoryProvider);
              await repo.deleteHealthEvent(widget.ref.read(effectivePetProvider)!.id, child.id);
              widget.ref.invalidate(healthAgendaProvider);
              widget.ref.invalidate(healthHistoryProvider(widget.ref.read(effectivePetProvider)!.id));
            }
            return false;
          }
        },
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: CircleAvatar(
              radius: 16,
              backgroundColor: color.withAlpha(51),
              child: Icon(icon, color: color, size: 16),
            ),
            title: Text(child.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat('dd MMM yy - HH:mm').format(child.date.toLocal()), style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                if (realParentTitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text('↳ Derivado de: $realParentTitle', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontStyle: FontStyle.italic)),
                  ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.visibility, color: Colors.grey),
              onPressed: () => _showEventDetails(context, child),
            ),
          ),
        ),
      ),
    );
  }

  void _showEventDetails(BuildContext context, HealthEventDto event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final occurrences = event.occurrences ?? [];
        return Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(event.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),
              
              // Event Details
              _detailRow('Fecha original', DateFormat('dd MMM yyyy - HH:mm').format(event.date.toLocal())),
              if (event.notes != null && event.notes!.isNotEmpty) _detailRow('Notas', event.notes!),
              event.map(
                vetVisit: (v) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (v.veterinarianName != null && v.veterinarianName!.isNotEmpty) _detailRow('Veterinario', v.veterinarianName!),
                    if (v.clinicName != null && v.clinicName!.isNotEmpty) _detailRow('Clínica', v.clinicName!),
                    if (v.diagnosis != null && v.diagnosis!.isNotEmpty) _detailRow('Diagnóstico', v.diagnosis!),
                    _detailRow('Hospitalización', v.isHospitalization ? 'Sí' : 'No'),
                  ],
                ),
                medication: (m) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailRow('Medicamento', m.drugName),
                    _detailRow('Dosis', m.dosage),
                    _detailRow('Frecuencia', '${m.frequencyValue} ${_getFrequencyUnitName(m.frequencyUnit)}'),
                  ],
                ),
                vaccine: (v) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailRow('Vacuna', v.vaccineName),
                    if (v.frequencyValue > 0) _detailRow('Recordatorio', 'Cada ${v.frequencyValue} ${_getFrequencyUnitName(v.frequencyUnit)}'),
                  ],
                ),
                custom: (c) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (c.frequencyValue > 0) _detailRow('Recordatorio', 'Cada ${c.frequencyValue} ${_getFrequencyUnitName(c.frequencyUnit)}'),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const Text('Registros', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              if (occurrences.isEmpty)
                const Text('No hay registros generados.', style: TextStyle(color: Colors.grey))
              else
                Flexible(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: occurrences.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final occ = occurrences[index];
                        final isCompleted = occ.status == 'Completed';
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            isCompleted ? Icons.check_circle : Icons.pending_actions,
                            color: isCompleted ? Colors.green : Colors.orange,
                          ),
                          title: Text(DateFormat('dd MMM yyyy - HH:mm').format(occ.scheduledDate.toLocal()), style: const TextStyle(fontSize: 14)),
                          subtitle: Text(isCompleted ? 'Completado' : 'Pendiente', style: TextStyle(color: isCompleted ? Colors.green : Colors.orange, fontSize: 12)),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  String _getFrequencyUnitName(int unit) {
    switch (unit) {
      case 0: return 'Horas';
      case 1: return 'Días';
      case 2: return 'Meses';
      case 3: return 'Años';
      case 4: return 'Semanas';
      default: return '';
    }
  }

  Widget _detailRow(String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black87, fontSize: 14),
          children: [
            TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

}

class _StickyDateHeaderDelegate extends SliverPersistentHeaderDelegate {
  final DateTime date;
  final ThemeData theme;

  _StickyDateHeaderDelegate({required this.date, required this.theme});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final dateStr = DateFormat('dd MMM yyyy').format(date);
    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      alignment: Alignment.centerLeft,
      child: Text(
        dateStr.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 40.0;

  @override
  double get minExtent => 40.0;

  @override
  bool shouldRebuild(covariant _StickyDateHeaderDelegate oldDelegate) {
    return oldDelegate.date != date;
  }
}