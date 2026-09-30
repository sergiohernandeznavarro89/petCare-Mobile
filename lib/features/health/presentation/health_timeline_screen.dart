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

class HealthTimelineScreen extends ConsumerWidget {
  const HealthTimelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                          Icon(Icons.pets, size: 64, color: theme.colorScheme.primary.withValues(alpha: 0.5)),
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
                      final parentEvents = events.where((e) {
                        return e.map(
                          vetVisit: (v) => v.parentId == null,
                          medication: (m) => m.parentId == null,
                          vaccine: (v) => v.parentId == null,
                          custom: (c) => c.parentId == null,
                        );
                      }).toList();

                      return RefreshIndicator(
                        onRefresh: () async => ref.invalidate(healthHistoryProvider(selectedPet.id)),
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16.0),
                          itemCount: parentEvents.length,
                          itemBuilder: (context, index) {
                            final parentEvent = parentEvents[index];
                            final children = events.where((e) {
                              return e.map(
                                vetVisit: (v) => v.parentId == parentEvent.id,
                                medication: (m) => m.parentId == parentEvent.id,
                                vaccine: (v) => v.parentId == parentEvent.id,
                                custom: (c) => c.parentId == parentEvent.id,
                              );
                            }).toList();
                            return _buildTimelineItem(context, ref, parentEvent, children, theme, index == parentEvents.length - 1);
                          },
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

  Widget _buildTimelineItem(BuildContext context, WidgetRef ref, HealthEventDto event, List<HealthEventDto> children, ThemeData theme, bool isLast) {
    IconData icon = Icons.medical_services;
    Color color = theme.colorScheme.primary;

    event.mapOrNull(
      vetVisit: (_) { icon = Icons.local_hospital; color = Colors.blue; },
      medication: (_) { icon = Icons.medication; color = Colors.orange; },
      vaccine: (_) { icon = Icons.vaccines; color = Colors.red; },
      custom: (_) { icon = Icons.star; color = Colors.purple; },
    );

    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: 2),
                  ),
                  child: Icon(icon, color: color, size: 16),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: Colors.grey.shade300,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Dismissible(
                key: ValueKey(event.id),
                direction: DismissDirection.horizontal,
                background: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.edit, color: Colors.white),
                ),
                secondaryBackground: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(16),
                  ),
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
                        petId: ref.read(effectivePetProvider)!.id,
                        existingEvent: event,
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
                      final repo = ref.read(healthRepositoryProvider);
                      await repo.deleteHealthEvent(ref.read(effectivePetProvider)!.id, event.id);
                      ref.invalidate(healthAgendaProvider);
                      ref.invalidate(healthHistoryProvider(ref.read(effectivePetProvider)!.id));
                    }
                    return false;
                  }
                },
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _showEventDetailsModal(context, event),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  event.title,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                              Text(
                                DateFormat('dd MMM yy').format(event.date),
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (event.notes != null && event.notes!.isNotEmpty)
                            Text(event.notes!, style: TextStyle(color: Colors.grey.shade700)),
                          if (event.weight != null) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('Peso: ${event.weight} kg', style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold, fontSize: 12)),
                            ),
                          ],
                          if (children.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            const Divider(),
                            ...children.map((child) => _buildChildEvent(child, theme)),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
            ),
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildEvent(HealthEventDto child, ThemeData theme) {
    IconData icon = Icons.event;
    Color color = theme.colorScheme.secondary;
    child.mapOrNull(
      vetVisit: (_) { icon = Icons.local_hospital; color = Colors.blue; },
      medication: (_) { icon = Icons.medication; color = Colors.orange; },
      vaccine: (_) { icon = Icons.vaccines; color = Colors.red; },
      custom: (_) { icon = Icons.star; color = Colors.purple; },
    );

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Icon(Icons.subdirectory_arrow_right, size: 16, color: Colors.grey.shade400),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 12,
            backgroundColor: color.withValues(alpha: 0.2),
            child: Icon(icon, color: color, size: 12),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(child.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                Text(DateFormat('dd MMM yy').format(child.date), style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEventDetailsModal(BuildContext context, HealthEventDto event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final start = DateTime(2000);
        final end = DateTime.now().add(const Duration(days: 365 * 2));
        final occurrences = event.frequencyValue > 0 ? event.generateOccurrences(start, end) : <HealthEventDto>[];

        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text(event.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 8),
                      Text('Fecha de inicio: ${DateFormat('dd MMM yyyy').format(event.date)}', style: TextStyle(color: Colors.grey.shade700, fontSize: 16)),
                    ],
                  ),
                  if (event.notes != null && event.notes!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text('Notas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(event.notes!, style: TextStyle(color: Colors.grey.shade700, fontSize: 15)),
                  ],
                  const SizedBox(height: 24),
                  if (occurrences.isNotEmpty) ...[
                    const Divider(),
                    const SizedBox(height: 8),
                    Text('Eventos Hijos (${occurrences.length})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        itemCount: occurrences.length,
                        separatorBuilder: (context, index) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final occ = occurrences[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                              child: Icon(Icons.event_repeat, color: Theme.of(context).colorScheme.primary),
                            ),
                            title: Text(DateFormat('dd MMM yyyy - HH:mm').format(occ.date)),
                          );
                        },
                      ),
                    ),
                  ] else ...[
                    const Divider(),
                    const SizedBox(height: 16),
                    Center(
                      child: Text('Este evento no tiene eventos hijos.', style: TextStyle(color: Colors.grey.shade500, fontStyle: FontStyle.italic)),
                    )
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}