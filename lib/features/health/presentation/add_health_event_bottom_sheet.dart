import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../domain/event_type_definition_dto.dart';
import '../domain/health_event_dto.dart';
import '../data/health_repository.dart';
import 'health_providers.dart';
import '../../pets/presentation/pets_provider.dart';
import '../../pets/domain/pet_avatar_helper.dart';

class AddHealthEventBottomSheet extends ConsumerStatefulWidget {
  final EventTypeDefinitionDto? preselectedEventType;
  final bool isCustomMode;
  final String? petId;
  final HealthEventDto? existingEvent;
  final String? parentId;

  const AddHealthEventBottomSheet({
    super.key,
    this.preselectedEventType,
    this.isCustomMode = false,
    this.petId,
    this.existingEvent,
    this.parentId,
  });

  @override
  ConsumerState<AddHealthEventBottomSheet> createState() => _AddHealthEventBottomSheetState();
}

class _AddHealthEventBottomSheetState extends ConsumerState<AddHealthEventBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  
  EventTypeDefinitionDto? _selectedEventType;
  DateTime _date = DateTime.now();
  String _title = '';
  String _notes = '';
  double? _weight;

  // Campos específicos
  String _clinicName = '';
  String _vetName = '';
  String _drugName = '';
  String _dosage = '';
  String _vaccineName = '';
  bool _isHospitalization = false;
  
  int _frequencyValue = 1;
  int _frequencyUnit = 1;
  bool _isRecurring = false;
  DateTime? _endDate;
  
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingEvent != null) {
      final ev = widget.existingEvent!;
      _selectedEventType = ev.eventType;
      _date = ev.date;
      _title = ev.title;
      _notes = ev.notes ?? '';
      _weight = ev.weight;
      
      ev.mapOrNull(
        vetVisit: (v) {
          _clinicName = v.clinicName ?? '';
          _vetName = v.veterinarianName ?? '';
          _isHospitalization = v.isHospitalization;
          _endDate = v.endDate;
        },
        medication: (m) {
          _drugName = m.drugName;
            _dosage = m.dosage;
            _frequencyValue = m.frequencyValue == 0 ? 1 : m.frequencyValue;
            _frequencyUnit = m.frequencyUnit;
            _isRecurring = m.frequencyValue > 0;
            _endDate = m.endDate;
        },
        vaccine: (v) {
            _vaccineName = v.vaccineName;
            _frequencyValue = v.frequencyValue == 0 ? 1 : v.frequencyValue;
            _frequencyUnit = v.frequencyUnit;
            _isRecurring = v.frequencyValue > 0;
            _endDate = v.endDate;
        },
        custom: (c) {
            _frequencyValue = c.frequencyValue == 0 ? 1 : c.frequencyValue;
            _frequencyUnit = c.frequencyUnit;
            _isRecurring = c.frequencyValue > 0;
            _endDate = c.endDate;
        },
      );
    } else if (!widget.isCustomMode && widget.preselectedEventType != null) {
      _selectedEventType = widget.preselectedEventType;
    }
  }

  IconData _getIconForType(EventTypeDefinitionDto? type) {
    if (type == null) return Icons.event;
    if (type.icon == 'local_hospital') return Icons.local_hospital;
    if (type.icon == 'medication') return Icons.medication;
    if (type.icon == 'vaccines') return Icons.vaccines;
    return Icons.star;
  }

  Color _getColorForType(EventTypeDefinitionDto? type, ThemeData theme) {
    if (type == null) return theme.colorScheme.primary;
    if (type.color == 'blue') return Colors.blue;
    if (type.color == 'orange') return Colors.orange;
    if (type.color == 'red') return Colors.red;
    return theme.colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    final eventTypesAsync = ref.watch(eventTypesProvider);
    final selectedPet = ref.watch(effectivePetProvider);
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            if (selectedPet == null) {
              return const Center(child: Text('Selecciona una mascota primero.'));
            }

            return Column(
              children: [
                // Handle/indicador de arrastre
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            if (!widget.isCustomMode && widget.preselectedEventType != null) ...[
                              CircleAvatar(
                                backgroundColor: _getColorForType(widget.preselectedEventType, theme).withAlpha(40),
                                child: Icon(
                                  _getIconForType(widget.preselectedEventType),
                                  color: _getColorForType(widget.preselectedEventType, theme),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  widget.preselectedEventType!.name,
                                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ] else if (widget.isCustomMode) ...[
                              CircleAvatar(
                                backgroundColor: Colors.purple.withAlpha(40),
                                child: const Icon(Icons.star, color: Colors.purple),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Evento Personalizado',
                                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ] else ...[
                              Text(
                                widget.existingEvent != null ? 'Editar Evento Médico' : 'Nuevo Evento Médico',
                                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ]
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: eventTypesAsync.when(
                    data: (types) {
                      if (types.isEmpty) {
                        return const Center(child: Text('No hay tipos de eventos configurados.'));
                      }
                      
                      final customTypes = types.where((t) => t.userId != null).toList();

                      return Form(
                        key: _formKey,
                        child: ListView(
                          controller: scrollController,
                          padding: const EdgeInsets.all(20),
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: theme.colorScheme.surface,
                                    backgroundImage: AssetImage(getPetAvatarPath(selectedPet.species, selectedPet.photoUrl)),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.existingEvent != null ? 'Editando evento Médico de' : 'Creando evento Médico para',
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: theme.colorScheme.onSurfaceVariant,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          selectedPet.name,
                                          style: theme.textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (widget.isCustomMode) ...[
                              if (customTypes.isEmpty)
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withAlpha(30),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text('No tienes eventos personalizados creados. Ve a Configuración para crear uno.'),
                                )
                              else
                                DropdownButtonFormField<EventTypeDefinitionDto>(
                                  value: _selectedEventType,
                                  decoration: const InputDecoration(labelText: 'Tipo de Evento Personalizado', border: OutlineInputBorder()),
                                  items: customTypes.map((t) => DropdownMenuItem(value: t, child: Text(t.name))).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedEventType = val;
                                    });
                                  },
                                  validator: (val) => val == null ? 'Selecciona un tipo' : null,
                                ),
                              const SizedBox(height: 16),
                            ],
                            
                            TextFormField(
                              initialValue: _title,
                              decoration: const InputDecoration(labelText: 'Título', border: OutlineInputBorder()),
                              onSaved: (val) => _title = val ?? '',
                              validator: (val) => val!.isEmpty ? 'Requerido' : null,
                            ),
                            const SizedBox(height: 16),
                            ListTile(
                              title: const Text('Fecha y Hora'),
                              subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(_date)),
                              trailing: const Icon(Icons.calendar_today),
                              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(4)),
                              enabled: widget.existingEvent == null || !widget.existingEvent!.hasCompletedOccurrences,
                              onTap: widget.existingEvent != null && widget.existingEvent!.hasCompletedOccurrences ? null : () async {
                                final d = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2000), lastDate: DateTime(2100));
                                if (d != null) {
                                  if (!mounted) return;
                                  final t = await showTimePicker(
                                    context: context, 
                                    initialTime: TimeOfDay.fromDateTime(_date),
                                    builder: (context, child) => MediaQuery(
                                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                      child: child!,
                                    ),
                                  );
                                  if (t != null) {
                                    setState(() => _date = DateTime(d.year, d.month, d.day, t.hour, t.minute));
                                  }
                                }
                              },
                            ),
                            if (widget.existingEvent != null && widget.existingEvent!.hasCompletedOccurrences)
                              Padding(
                                padding: const EdgeInsets.only(top: 4, bottom: 8),
                                child: Text(
                                  'La fecha y hora no se pueden editar porque ya hay registros completados para este evento.',
                                  style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                                ),
                              ),
                            const SizedBox(height: 16),
                            
                            if (_selectedEventType?.name.toLowerCase().contains('visita') == true) ...[
                              TextFormField(
                                initialValue: _clinicName,
                                decoration: const InputDecoration(labelText: 'Clínica', border: OutlineInputBorder()),
                                onSaved: (val) => _clinicName = val ?? '',
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                initialValue: _vetName,
                                decoration: const InputDecoration(labelText: 'Veterinario', border: OutlineInputBorder()),
                                onSaved: (val) => _vetName = val ?? '',
                              ),
                              CheckboxListTile(
                                title: const Text('¿Requiere Hospitalización?'),
                                value: _isHospitalization,
                                onChanged: (val) => setState(() => _isHospitalization = val ?? false),
                              ),
                            ] else if (_selectedEventType?.name.toLowerCase().contains('medic') == true) ...[
                               TextFormField(
                                initialValue: _drugName,
                                decoration: const InputDecoration(labelText: 'Nombre del Medicamento', border: OutlineInputBorder()),
                                onSaved: (val) => _drugName = val ?? '',
                              ),
                              const SizedBox(height: 16),
                               TextFormField(
                                initialValue: _dosage,
                                decoration: const InputDecoration(labelText: 'Dosis (ej: 1 Pastilla)', border: OutlineInputBorder()),
                                onSaved: (val) => _dosage = val ?? '',
                              ),
                              const SizedBox(height: 16),
                              SwitchListTile(
                                title: const Text('¿Es un evento repetitivo?'),
                                value: _isRecurring,
                                onChanged: (val) => setState(() => _isRecurring = val),
                                contentPadding: EdgeInsets.zero,
                              ),
                              if (_isRecurring) ...[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        initialValue: _frequencyValue.toString(),
                                        decoration: const InputDecoration(labelText: 'Frecuencia', border: OutlineInputBorder()),
                                        keyboardType: TextInputType.number,
                                        onSaved: (val) => _frequencyValue = int.tryParse(val ?? '') ?? 1,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      flex: 1,
                                      child: DropdownButtonFormField<int>(
                                        initialValue: _frequencyUnit,
                                        decoration: const InputDecoration(labelText: 'Unidad', border: OutlineInputBorder()),
                                        items: const [
                                          DropdownMenuItem(value: 0, child: Text('Horas')),
                                          DropdownMenuItem(value: 1, child: Text('Días')),
                                          DropdownMenuItem(value: 4, child: Text('Semanas')),
                                          DropdownMenuItem(value: 2, child: Text('Meses')),
                                          DropdownMenuItem(value: 3, child: Text('Años')),
                                        ],
                                        onChanged: (val) {
                                          if (val != null) setState(() => _frequencyUnit = val);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                ListTile(
                                  title: const Text('Fecha Fin (Opcional)'),
                                  subtitle: Text(_endDate != null ? DateFormat('dd/MM/yyyy HH:mm').format(_endDate!) : 'Sin límite de fecha'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (_endDate != null)
                                        IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () => setState(() => _endDate = null),
                                        ),
                                      const Icon(Icons.calendar_today),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(4)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                  onTap: () async {
                                    final d = await showDatePicker(context: context, initialDate: _endDate ?? _date.add(const Duration(days: 1)), firstDate: _date, lastDate: DateTime(2100));
                                    if (d != null) {
                                      if (!mounted) return;
                                      final t = await showTimePicker(
                                        context: context, 
                                        initialTime: TimeOfDay.fromDateTime(_endDate ?? _date),
                                        builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!),
                                      );
                                      if (t != null) setState(() => _endDate = DateTime(d.year, d.month, d.day, t.hour, t.minute));
                                    }
                                  },
                                ),
                              ],
                            ] else if (_selectedEventType?.name.toLowerCase().contains('vacun') == true) ...[
                               TextFormField(
                                initialValue: _vaccineName,
                                decoration: const InputDecoration(labelText: 'Nombre de la Vacuna', border: OutlineInputBorder()),
                                onSaved: (val) => _vaccineName = val ?? '',
                              ),
                              const SizedBox(height: 16),
                              SwitchListTile(
                                title: const Text('¿Es un evento repetitivo?'),
                                value: _isRecurring,
                                onChanged: (val) => setState(() => _isRecurring = val),
                                contentPadding: EdgeInsets.zero,
                              ),
                              if (_isRecurring) ...[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        initialValue: _frequencyValue.toString(),
                                        decoration: const InputDecoration(labelText: 'Recordatorio cada', border: OutlineInputBorder()),
                                        keyboardType: TextInputType.number,
                                        onSaved: (val) => _frequencyValue = int.tryParse(val ?? '') ?? 1,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      flex: 1,
                                      child: DropdownButtonFormField<int>(
                                        initialValue: _frequencyUnit,
                                        decoration: const InputDecoration(labelText: 'Unidad', border: OutlineInputBorder()),
                                        items: const [
                                          DropdownMenuItem(value: 0, child: Text('Horas')),
                                          DropdownMenuItem(value: 1, child: Text('Días')),
                                          DropdownMenuItem(value: 4, child: Text('Semanas')),
                                          DropdownMenuItem(value: 2, child: Text('Meses')),
                                          DropdownMenuItem(value: 3, child: Text('Años')),
                                        ],
                                        onChanged: (val) {
                                          if (val != null) setState(() => _frequencyUnit = val);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                ListTile(
                                  title: const Text('Fecha Fin (Opcional)'),
                                  subtitle: Text(_endDate != null ? DateFormat('dd/MM/yyyy HH:mm').format(_endDate!) : 'Sin límite de fecha'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (_endDate != null)
                                        IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () => setState(() => _endDate = null),
                                        ),
                                      const Icon(Icons.calendar_today),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(4)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                  onTap: () async {
                                    final d = await showDatePicker(context: context, initialDate: _endDate ?? _date.add(const Duration(days: 1)), firstDate: _date, lastDate: DateTime(2100));
                                    if (d != null) {
                                      if (!mounted) return;
                                      final t = await showTimePicker(
                                        context: context, 
                                        initialTime: TimeOfDay.fromDateTime(_endDate ?? _date),
                                        builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!),
                                      );
                                      if (t != null) setState(() => _endDate = DateTime(d.year, d.month, d.day, t.hour, t.minute));
                                    }
                                  },
                                ),
                              ],
                            ] else if (widget.isCustomMode) ...[
                              SwitchListTile(
                                title: const Text('¿Es un evento repetitivo?'),
                                value: _isRecurring,
                                onChanged: (val) => setState(() => _isRecurring = val),
                                contentPadding: EdgeInsets.zero,
                              ),
                              if (_isRecurring) ...[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        initialValue: _frequencyValue.toString(),
                                        decoration: const InputDecoration(labelText: 'Frecuencia', border: OutlineInputBorder()),
                                        keyboardType: TextInputType.number,
                                        onSaved: (val) => _frequencyValue = int.tryParse(val ?? '') ?? 1,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      flex: 1,
                                      child: DropdownButtonFormField<int>(
                                        initialValue: _frequencyUnit,
                                        decoration: const InputDecoration(labelText: 'Unidad', border: OutlineInputBorder()),
                                        items: const [
                                          DropdownMenuItem(value: 0, child: Text('Horas')),
                                          DropdownMenuItem(value: 1, child: Text('Días')),
                                          DropdownMenuItem(value: 4, child: Text('Semanas')),
                                          DropdownMenuItem(value: 2, child: Text('Meses')),
                                          DropdownMenuItem(value: 3, child: Text('Años')),
                                        ],
                                        onChanged: (val) {
                                          if (val != null) setState(() => _frequencyUnit = val);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                ListTile(
                                  title: const Text('Fecha Fin (Opcional)'),
                                  subtitle: Text(_endDate != null ? DateFormat('dd/MM/yyyy HH:mm').format(_endDate!) : 'Sin límite de fecha'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (_endDate != null)
                                        IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () => setState(() => _endDate = null),
                                        ),
                                      const Icon(Icons.calendar_today),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(4)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                  onTap: () async {
                                    final d = await showDatePicker(context: context, initialDate: _endDate ?? _date.add(const Duration(days: 1)), firstDate: _date, lastDate: DateTime(2100));
                                    if (d != null) {
                                      if (!mounted) return;
                                      final t = await showTimePicker(
                                        context: context, 
                                        initialTime: TimeOfDay.fromDateTime(_endDate ?? _date),
                                        builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!),
                                      );
                                      if (t != null) setState(() => _endDate = DateTime(d.year, d.month, d.day, t.hour, t.minute));
                                    }
                                  },
                                ),
                              ],
                            ],

                            const SizedBox(height: 16),
                            TextFormField(
                              initialValue: _notes,
                              decoration: const InputDecoration(labelText: 'Notas Adicionales', border: OutlineInputBorder()),
                              maxLines: 3,
                              onSaved: (val) => _notes = val ?? '',
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: _isLoading ? null : () => _submit(selectedPet.id),
                              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                              child: _isLoading ? const CircularProgressIndicator() : Text(widget.existingEvent != null ? 'Actualizar Evento' : 'Guardar Evento'),
                            ),
                          ],
                        ),
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, _) => Center(child: Text('Error: $error')),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _submit(String petId) async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (_selectedEventType == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecciona un tipo de evento.')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final repo = ref.read(healthRepositoryProvider);
      HealthEventDto dto;

      final name = _selectedEventType!.name.toLowerCase();
      if (name.contains('visita')) {
        dto = HealthEventDto.vetVisit(
          id: '00000000-0000-0000-0000-000000000000', petId: petId, eventType: _selectedEventType!, date: _date, title: _title, notes: _notes, weight: _weight,
          clinicName: _clinicName, veterinarianName: _vetName, isHospitalization: _isHospitalization, parentId: widget.parentId, endDate: _endDate
        );
      } else if (name.contains('medic')) {
        dto = HealthEventDto.medication(
          id: '00000000-0000-0000-0000-000000000000', petId: petId, eventType: _selectedEventType!, date: _date, title: _title, notes: _notes, weight: _weight,
          drugName: _drugName, dosage: _dosage, frequencyValue: _isRecurring ? _frequencyValue : 0, frequencyUnit: _frequencyUnit, startDate: _date, parentId: widget.parentId, endDate: _endDate
        );
      } else if (name.contains('vacun')) {
        dto = HealthEventDto.vaccine(
          id: '00000000-0000-0000-0000-000000000000', petId: petId, eventType: _selectedEventType!, date: _date, title: _title, notes: _notes, weight: _weight,
          vaccineName: _vaccineName, frequencyValue: _isRecurring ? _frequencyValue : 0, frequencyUnit: _frequencyUnit, parentId: widget.parentId, endDate: _endDate
        );
      } else {
        dto = HealthEventDto.custom(
          id: '00000000-0000-0000-0000-000000000000', petId: petId, eventType: _selectedEventType!, date: _date, title: _title, notes: _notes, weight: _weight,
          frequencyValue: _isRecurring ? _frequencyValue : 0, frequencyUnit: _frequencyUnit, parentId: widget.parentId, endDate: _endDate
        );
      }

      if (widget.existingEvent != null) {
        dto = dto.copyWith(id: widget.existingEvent!.id);
        await repo.updateHealthEvent(petId, widget.existingEvent!.id, dto);
      } else {
        await repo.createHealthEvent(petId, dto);
      }
      
      ref.invalidate(healthAgendaProvider);
      ref.invalidate(healthHistoryProvider(petId));

      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
