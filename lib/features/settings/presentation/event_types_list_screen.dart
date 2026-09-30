import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../health/domain/event_type_definition_dto.dart';
import '../../health/presentation/health_providers.dart';
import '../../health/presentation/widgets/event_type_form_bottom_sheet.dart';
import '../../health/data/health_repository.dart';

class EventTypesListScreen extends ConsumerWidget {
  const EventTypesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventTypesAsync = ref.watch(eventTypesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tipos de Evento'),
      ),
      body: eventTypesAsync.when(
        data: (types) {
          if (types.isEmpty) {
            return const Center(child: Text('No hay eventos personalizados.'));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(eventTypesProvider),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              itemCount: types.length,
              itemBuilder: (context, index) {
                final type = types[index];
                final isSystem = type.userId == null;

                IconData iconData = Icons.event;
                switch (type.icon) {
                  case 'local_hospital': iconData = Icons.local_hospital; break;
                  case 'medication': iconData = Icons.medication; break;
                  case 'vaccines': iconData = Icons.vaccines; break;
                  case 'favorite': iconData = Icons.favorite; break;
                  case 'pets': iconData = Icons.pets; break;
                  case 'healing': iconData = Icons.healing; break;
                  case 'spa': iconData = Icons.spa; break;
                  case 'star': iconData = Icons.star; break;
                }

                Color color = theme.colorScheme.primary;
                switch (type.color) {
                  case 'blue': color = Colors.blue; break;
                  case 'orange': color = Colors.orange; break;
                  case 'red': color = Colors.red; break;
                  case 'green': color = Colors.green; break;
                  case 'teal': color = Colors.teal; break;
                  case 'pink': color = Colors.pink; break;
                  case 'indigo': color = Colors.indigo; break;
                  case 'amber': color = Colors.amber; break;
                  case 'cyan': color = Colors.cyan; break;
                  case 'purple': color = Colors.purple; break;
                }

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shadowColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: isSystem
                    ? _buildCardContent(context, type, isSystem, color, iconData, theme)
                    : Dismissible(
                      key: ValueKey(type.id),
                      direction: DismissDirection.horizontal,
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => EventTypeFormBottomSheet(typeToEdit: type),
                          );
                          return false;
                        } else if (direction == DismissDirection.endToStart) {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Eliminar evento'),
                              content: Text('¿Estás seguro de que deseas eliminar el evento personalizado "${type.name}"?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancelar')),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                                  child: const Text('Eliminar'),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            await ref.read(healthRepositoryProvider).deleteEventType(type.id);
                            ref.invalidate(eventTypesProvider);
                          }
                          return false;
                        }
                        return false;
                      },
                      background: Container(
                        color: theme.colorScheme.primary,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20),
                        child: const Icon(Icons.edit, color: Colors.white),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: _buildCardContent(context, type, isSystem, color, iconData, theme),
                    ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const EventTypeFormBottomSheet(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context, EventTypeDefinitionDto type, bool isSystem, Color color, IconData iconData, ThemeData theme) {
    return InkWell(
      onTap: isSystem ? null : () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => EventTypeFormBottomSheet(typeToEdit: type),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withAlpha(60), width: 1.5),
              ),
              child: Icon(iconData, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSystem ? Colors.grey.withAlpha(30) : theme.colorScheme.primary.withAlpha(30),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSystem ? Colors.grey.withAlpha(60) : theme.colorScheme.primary.withAlpha(60),
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSystem ? Icons.lock_outline : Icons.person_outline,
                          size: 12,
                          color: isSystem ? Colors.grey.shade700 : theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isSystem ? 'Sistema' : 'Personalizado',
                          style: TextStyle(
                            color: isSystem ? Colors.grey.shade700 : theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}