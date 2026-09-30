import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../health_providers.dart';
import '../add_health_event_bottom_sheet.dart';
import '../../domain/event_type_definition_dto.dart';

class EventSpeedDial extends ConsumerWidget {
  const EventSpeedDial({super.key});

  void _openSheet(BuildContext context, {EventTypeDefinitionDto? type, bool isCustom = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddHealthEventBottomSheet(
        preselectedEventType: type,
        isCustomMode: isCustom,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final eventTypesAsync = ref.watch(eventTypesProvider);

    return eventTypesAsync.when(
      data: (types) {
        final systemTypes = types.where((t) => t.userId == null).toList();
        
        List<SpeedDialChild> children = [];
        
        // Add System Types
        for (var type in systemTypes) {
          IconData iconData = Icons.event;
          if (type.icon == 'local_hospital') iconData = Icons.local_hospital;
          if (type.icon == 'medication') iconData = Icons.medication;
          if (type.icon == 'vaccines') iconData = Icons.vaccines;

          Color color = theme.colorScheme.primary;
          if (type.color == 'blue') color = Colors.blue;
          if (type.color == 'orange') color = Colors.orange;
          if (type.color == 'red') color = Colors.red;

          children.add(
            SpeedDialChild(
              child: Icon(iconData, color: Colors.white),
              backgroundColor: color,
              label: type.name,
              labelStyle: const TextStyle(fontWeight: FontWeight.w500),
              onTap: () => _openSheet(context, type: type),
            )
          );
        }

        // Add Custom Event Option
        children.add(
          SpeedDialChild(
            child: const Icon(Icons.star, color: Colors.white),
            backgroundColor: Colors.purple,
            label: 'Evento Personalizado',
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            onTap: () => _openSheet(context, isCustom: true),
          )
        );

        return SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 12,
          spaceBetweenChildren: 12,
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          children: children,
        );
      },
      loading: () => FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.grey,
        child: const CircularProgressIndicator(color: Colors.white),
      ),
      error: (_, __) => FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.red,
        child: const Icon(Icons.error),
      ),
    );
  }
}