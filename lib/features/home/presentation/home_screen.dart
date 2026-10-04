import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../health/data/health_repository.dart';
import 'package:go_router/go_router.dart';
import '../../health/presentation/widgets/event_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../pets/domain/pet_dto.dart';
import '../../pets/domain/pet_avatar_helper.dart';
import '../../pets/presentation/pets_provider.dart';
import '../../pets/presentation/widgets/horizontal_pet_card.dart';
import '../../health/presentation/health_providers.dart';
import '../../health/domain/health_event_dto.dart';
import '../../health/domain/health_event_occurrence_dto.dart';
import '../../health/domain/health_event_occurrence_dto.dart';
import '../../health/presentation/multi_derived_event_selection_bottom_sheet.dart';
import '../../health/presentation/multi_add_health_events_bottom_sheet.dart';
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isCalendarView = false;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _itemsToShow = 10;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    final petsAsync = ref.watch(petsProvider);
    final selectedPet = ref.watch(selectedPetProvider);
    final agendaAsync = ref.watch(healthAgendaProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda y Citas'),
        actions: [
          IconButton(
            icon: Icon(_isCalendarView ? Icons.view_list_rounded : Icons.calendar_month_rounded),
            onPressed: () {
              setState(() {
                _isCalendarView = !_isCalendarView;
              });
            },
            tooltip: _isCalendarView ? 'Ver como lista' : 'Ver como calendario',
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: const EventSpeedDial(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16.0),
          SizedBox(
            height: 140,
            child: petsAsync.when(
              data: (pets) {
                if (pets.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: InkWell(
                      onTap: () => context.go('/settings/pets'),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer.withAlpha(40),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: theme.colorScheme.primary.withAlpha(80)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.pets, color: theme.colorScheme.primary, size: 32),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Text('¡Añade tu primera mascota para empezar!', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
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
                          ref.invalidate(selectedPetProvider);
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              selectedPet == null ? 'Próximos eventos (Todas las mascotas)' : 'Próximos eventos para ${selectedPet.name}',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(petsProvider);
                ref.invalidate(healthAgendaProvider);
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  ...agendaAsync.when(
              data: (events) {
                if (events.isEmpty) {
                  return [SliverToBoxAdapter(child: _buildEmptyAgenda(theme))];
                }
                return _isCalendarView 
                    ? [SliverToBoxAdapter(child: _buildCalendarView(events, theme))]
                    : _buildListViewSlivers(events, theme, selectedPet == null);
              },
              loading: () => [
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                )
              ],
              error: (error, _) => [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Error al cargar la agenda: $error', style: const TextStyle(color: Colors.red)),
                  )
                )
              ],
            ),
          ],
        ),
      ),
    ),
        ],
      ),
    );
  }

  Widget _buildEmptyAgenda(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.event_available, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No hay eventos programados.',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildListViewSlivers(List<HealthEventOccurrenceDto> events, ThemeData theme, bool showPetInfo) {
    final displayedEvents = events.take(_itemsToShow).toList();
    final hasMoreToDisplay = events.length > _itemsToShow;

    final groupedEvents = <DateTime, List<HealthEventOccurrenceDto>>{};
    for (var event in displayedEvents) {
      final localDate = event.scheduledDate.toLocal();
      final date = DateTime(localDate.year, localDate.month, localDate.day);
      if (!groupedEvents.containsKey(date)) {
        groupedEvents[date] = [];
      }
      groupedEvents[date]!.add(event);
    }

    final slivers = <Widget>[];

    for (final entry in groupedEvents.entries) {
      final date = entry.key;
      final dayEvents = entry.value;

      slivers.add(
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
                (context, index) => _buildEventCard(dayEvents[index], theme, showPetInfo, ref),
                childCount: dayEvents.length,
              ),
            ),
          ],
        ),
      );
    }

    if (hasMoreToDisplay) {
      slivers.add(
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _itemsToShow += 10;
                });
                ref.read(healthAgendaProvider.notifier).fetchNextPage();
              },
              icon: const Icon(Icons.expand_more),
              label: const Text('Ver más'),
            ),
          ),
        ),
      );
    }

    return slivers;
  }

  Widget _buildCalendarView(List<HealthEventOccurrenceDto> events, ThemeData theme) {
    Map<DateTime, List<HealthEventOccurrenceDto>> groupedEvents = {};
    for (var event in events) {
      final localDate = event.scheduledDate.toLocal();
      final date = DateTime(localDate.year, localDate.month, localDate.day);
      if (groupedEvents[date] == null) groupedEvents[date] = [];
      groupedEvents[date]!.add(event);
    }

    final selectedEvents = groupedEvents[DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day)] ?? [];

    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.now().subtract(const Duration(days: 365)),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          eventLoader: (day) {
            return groupedEvents[DateTime(day.year, day.month, day.day)] ?? [];
          },
          calendarStyle: CalendarStyle(
            markerDecoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          availableCalendarFormats: const {
            CalendarFormat.month: 'Mes',
          },
        ),
        const SizedBox(height: 16),
        if (selectedEvents.isEmpty)
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('No hay eventos este día.'),
          )
        else
          ...selectedEvents.map((e) => _buildEventCard(e, theme, true, ref)),
      ],
    );
  }

  Widget _buildEventCard(HealthEventOccurrenceDto occurrence, ThemeData theme, bool showPetInfo, WidgetRef ref) {
    final event = occurrence.healthEvent!;
    IconData icon = Icons.event;
    Color color = theme.colorScheme.primary;

    event.mapOrNull(
      vetVisit: (_) { icon = Icons.local_hospital; color = Colors.blue; },
      medication: (_) { icon = Icons.medication; color = Colors.orange; },
      vaccine: (_) { icon = Icons.vaccines; color = Colors.red; },
      custom: (_) { icon = Icons.star; color = Colors.purple; },
    );

    PetDto? pet;
    if (showPetInfo) {
      final pets = ref.read(petsProvider).value ?? [];
      pet = pets.where((p) => p.id == event.petId).firstOrNull;
    }

    return Dismissible(
      key: Key(occurrence.id),
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.check, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.blueGrey,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.more_horiz, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          try {
            if (!context.mounted) return false;
            
            bool canHaveDerived = event.maybeMap(
              vetVisit: (v) => true,
              custom: (c) => true,
              orElse: () => false,
            );

            bool wantsDerived = false;

            if (canHaveDerived) {
              final result = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Añadir evento derivado'),
                  content: const Text('¿Deseas programar una revisión o evento derivado para este evento?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('No')),
                    FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Sí')),
                  ],
                ),
              );

              if (result == null) return false; // Dialog dismissed
              wantsDerived = result;
            }

            if (wantsDerived && context.mounted) {
              final eventTypes = ref.read(eventTypesProvider).whenOrNull(data: (d) => d) ?? [];

              final selectedTypes = await showModalBottomSheet<List<SelectedDerivedEventType>>(
                context: context,
                isScrollControlled: true,
                builder: (ctx) => const MultiDerivedEventSelectionBottomSheet(),
              );

              if (selectedTypes == null || selectedTypes.isEmpty) return false; // Selection cancelled

              if (!context.mounted) return false;
              final eventCreated = await showModalBottomSheet<bool>(
                context: context,
                isScrollControlled: true,
                builder: (context) => MultiAddHealthEventsBottomSheet(
                  petId: event.petId,
                  parentId: event.id,
                  selectedTypes: selectedTypes,
                ),
              );

              if (eventCreated != true) return false; // Event creation cancelled
            }

            // Finally, complete occurrence
            if (!context.mounted) return false;
            bool wasLast = await ref.read(healthRepositoryProvider).completeOccurrence(occurrence.id);
            ref.read(healthAgendaProvider.notifier).removeOccurrenceLocally(occurrence.id);
            ref.invalidate(healthAgendaProvider);
            
            if (wasLast && context.mounted) {
              final extendResult = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Último evento repetitivo'),
                  content: const Text('Has completado el último evento generado para esta serie. ¿Deseas seguir generando eventos de este tipo por otros 2 años?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('No, finalizar')),
                    FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Sí, extender')),
                  ],
                ),
              );
              if (extendResult == true && context.mounted) {
                await ref.read(healthRepositoryProvider).extendHealthEvent(event.petId, event.id);
                ref.invalidate(healthAgendaProvider);
                ref.invalidate(healthHistoryProvider(event.petId));
              }
            }
            return true;
          } catch (e) {
            return false;
          }
        } else {
          final result = await showModalBottomSheet<Map<String, dynamic>>(
            context: context,
            isScrollControlled: true,
            builder: (ctx) {
              bool isPostponing = false;
              DateTime? selectedDate;
              
              return StatefulBuilder(
                builder: (context, setState) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 16,
                      right: 16,
                      top: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Descartar evento',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        const Text('¿Estás seguro de que deseas descartar este evento?'),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Switch(
                              value: isPostponing,
                              onChanged: (val) async {
                                if (val == true) {
                                  final localScheduledDate = occurrence.scheduledDate.toLocal();
                                  final newDate = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate ?? localScheduledDate,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(const Duration(days: 365)),
                                  );
                                  if (newDate != null) {
                                    if (!context.mounted) return;
                                    final newTime = await _showSwipeableTimePicker(
                                      context,
                                      TimeOfDay.fromDateTime(selectedDate ?? localScheduledDate),
                                    );
                                    if (newTime != null) {
                                      setState(() {
                                        isPostponing = true;
                                        selectedDate = DateTime(newDate.year, newDate.month, newDate.day, newTime.hour, newTime.minute);
                                      });
                                    } else {
                                      setState(() { isPostponing = false; });
                                    }
                                  } else {
                                    setState(() { isPostponing = false; });
                                  }
                                } else {
                                  setState(() {
                                    isPostponing = false;
                                  });
                                }
                              },
                            ),
                            const SizedBox(width: 8),
                            const Text('Posponer en lugar de descartar'),
                          ],
                        ),
                        if (isPostponing && selectedDate != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_month, color: Colors.blueGrey, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  DateFormat('dd MMM yyyy, HH:mm').format(selectedDate!),
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit, size: 18),
                                  onPressed: () async {
                                    final localScheduledDate = occurrence.scheduledDate.toLocal();
                                    final newDate = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate ?? localScheduledDate,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now().add(const Duration(days: 365)),
                                    );
                                    if (newDate != null) {
                                      if (!context.mounted) return;
                                      final newTime = await _showSwipeableTimePicker(
                                        context,
                                        TimeOfDay.fromDateTime(selectedDate ?? localScheduledDate),
                                      );
                                      if (newTime != null) {
                                        setState(() {
                                          selectedDate = DateTime(newDate.year, newDate.month, newDate.day, newTime.hour, newTime.minute);
                                        });
                                      }
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, null),
                              child: const Text('Cancelar'),
                            ),
                            const SizedBox(width: 8),
                            FilledButton(
                              style: isPostponing ? null : FilledButton.styleFrom(backgroundColor: Colors.red),
                              onPressed: () {
                                if (isPostponing && selectedDate != null) {
                                  Navigator.pop(ctx, {'action': 'postpone', 'date': selectedDate});
                                } else {
                                  Navigator.pop(ctx, {'action': 'discard'});
                                }
                              },
                              child: Text(isPostponing ? 'Posponer' : 'Descartar'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              );
            },
          );

          if (result == null) return false;

          if (result['action'] == 'discard') {
            try {
              if (!context.mounted) return false;
              await ref.read(healthRepositoryProvider).cancelOccurrence(occurrence.id);
              ref.read(healthAgendaProvider.notifier).removeOccurrenceLocally(occurrence.id);
              ref.invalidate(healthAgendaProvider);
              return true;
            } catch (e) {
              return false;
            }
          } else if (result['action'] == 'postpone') {
            try {
              if (!context.mounted) return false;
              final finalDate = result['date'] as DateTime;
              await ref.read(healthRepositoryProvider).postponeOccurrence(occurrence.id, finalDate);
              ref.read(healthAgendaProvider.notifier).removeOccurrenceLocally(occurrence.id);
              ref.invalidate(healthAgendaProvider);
              return true;
            } catch (e) {
              return false;
            }
          }
          return false;
        }
      },
      child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withAlpha(51),
          child: Icon(icon, color: color),
        ),
        title: Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat('HH:mm').format(occurrence.scheduledDate.toLocal())),
          ],
        ),
        trailing: (showPetInfo && pet != null)
            ? Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: theme.colorScheme.surfaceContainer,
                    backgroundImage: AssetImage(getPetAvatarPath(pet.species, pet.photoUrl)),
                  ),
                  const SizedBox(height: 4),
                  Text(pet.name, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: theme.colorScheme.primary)),
                ],
              )
            : null,
        onTap: () {},
      ),
    ),
    );
  }

  Future<TimeOfDay?> _showSwipeableTimePicker(BuildContext context, TimeOfDay initialTime) async {
    TimeOfDay? selectedTime = initialTime;
    final theme = Theme.of(context);
    
    final result = await showCupertinoModalPopup<bool>(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 280,
          color: theme.scaffoldBackgroundColor,
          child: Column(
            children: [
              Material(
                color: theme.colorScheme.surface,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: () => Navigator.of(builder).pop(false),
                    ),
                    TextButton(
                      child: const Text('Aceptar'),
                      onPressed: () => Navigator.of(builder).pop(true),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  initialDateTime: DateTime(2020, 1, 1, initialTime.hour, initialTime.minute),
                  onDateTimeChanged: (DateTime newDateTime) {
                    selectedTime = TimeOfDay.fromDateTime(newDateTime);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
    
    if (result == true) {
      return selectedTime;
    }
    return null;
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