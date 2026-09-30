import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/event_type_definition_dto.dart';
import 'health_providers.dart';

class SelectedDerivedEventType {
  final EventTypeDefinitionDto? type;
  final bool isCustom;
  final String uniqueId;

  SelectedDerivedEventType({
    required this.type,
    required this.isCustom,
  }) : uniqueId = UniqueKey().toString();
}

class MultiDerivedEventSelectionBottomSheet extends ConsumerStatefulWidget {
  const MultiDerivedEventSelectionBottomSheet({super.key});

  @override
  ConsumerState<MultiDerivedEventSelectionBottomSheet> createState() => _MultiDerivedEventSelectionBottomSheetState();
}

class _MultiDerivedEventSelectionBottomSheetState extends ConsumerState<MultiDerivedEventSelectionBottomSheet> {
  final List<SelectedDerivedEventType> _selectedTypes = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eventTypes = ref.watch(eventTypesProvider).whenOrNull(data: (d) => d) ?? [];
    final systemTypes = eventTypes.where((t) => t.userId == null).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Eventos derivados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Selecciona uno o varios eventos que deseas generar:'),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  ...systemTypes.map((type) {
                    IconData iconData = Icons.event;
                    if (type.icon == 'local_hospital') iconData = Icons.local_hospital;
                    if (type.icon == 'medication') iconData = Icons.medication;
                    if (type.icon == 'vaccines') iconData = Icons.vaccines;
                    
                    Color color = theme.colorScheme.primary;
                    if (type.color == 'blue') color = Colors.blue;
                    if (type.color == 'orange') color = Colors.orange;
                    if (type.color == 'red') color = Colors.red;
                    
                    final count = _selectedTypes.where((e) => e.type?.id == type.id).length;

                    return ListTile(
                      leading: CircleAvatar(backgroundColor: color.withValues(alpha: 0.2), child: Icon(iconData, color: color)),
                      title: Text(type.name),
                      subtitle: Text('Añadir evento de ${type.name.toLowerCase()}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: count > 0 ? () {
                              setState(() {
                                final lastIndex = _selectedTypes.lastIndexWhere((e) => e.type?.id == type.id);
                                if (lastIndex != -1) _selectedTypes.removeAt(lastIndex);
                              });
                            } : null,
                          ),
                          Text('$count', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                _selectedTypes.add(SelectedDerivedEventType(type: type, isCustom: false));
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                  const Divider(),
                  ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.purple.withValues(alpha: 0.2), child: const Icon(Icons.star, color: Colors.purple)),
                    title: const Text('Eventos Personalizados'),
                    subtitle: const Text('Añade múltiples eventos personalizados'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: _selectedTypes.where((e) => e.isCustom).isNotEmpty ? () {
                            setState(() {
                              final lastIndex = _selectedTypes.lastIndexWhere((e) => e.isCustom);
                              if (lastIndex != -1) _selectedTypes.removeAt(lastIndex);
                            });
                          } : null,
                        ),
                        Text('${_selectedTypes.where((e) => e.isCustom).length}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            setState(() {
                              _selectedTypes.add(SelectedDerivedEventType(type: null, isCustom: true));
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilledButton(
                onPressed: _selectedTypes.isNotEmpty ? () {
                  Navigator.pop(context, _selectedTypes);
                } : null,
                style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('Continuar', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
