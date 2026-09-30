import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../domain/event_type_definition_dto.dart';
import '../domain/health_event_dto.dart';
import '../data/health_repository.dart';
import 'health_providers.dart';
import 'multi_derived_event_selection_bottom_sheet.dart';

class DerivedEventFormData {
  final SelectedDerivedEventType selectedType;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  EventTypeDefinitionDto? finalEventType;
  DateTime date = DateTime.now();
  String title = '';
  String notes = '';
  
  // Specific
  String clinicName = '';
  String vetName = '';
  String drugName = '';
  String dosage = '';
  String vaccineName = '';
  bool isHospitalization = false;
  
  int frequencyValue = 1;
  int frequencyUnit = 1;
  bool isRecurring = false;
  
  bool get isCustom => selectedType.isCustom;
  EventTypeDefinitionDto? get type => selectedType.type;
  
  DerivedEventFormData(this.selectedType) {
    if (!isCustom) {
      finalEventType = type;
    }
  }

  bool get isComplete {
    if (isCustom && finalEventType == null) return false;
    if (title.trim().isEmpty) return false;
    
    final typeName = finalEventType?.name.toLowerCase() ?? '';
    if (typeName.contains('medic') && drugName.trim().isEmpty) return false;
    if (typeName.contains('vacun') && vaccineName.trim().isEmpty) return false;
    
    return true;
  }
}

class MultiAddHealthEventsBottomSheet extends ConsumerStatefulWidget {
  final String petId;
  final String parentId;
  final List<SelectedDerivedEventType> selectedTypes;

  const MultiAddHealthEventsBottomSheet({
    super.key,
    required this.petId,
    required this.parentId,
    required this.selectedTypes,
  });

  @override
  ConsumerState<MultiAddHealthEventsBottomSheet> createState() => _MultiAddHealthEventsBottomSheetState();
}

class _MultiAddHealthEventsBottomSheetState extends ConsumerState<MultiAddHealthEventsBottomSheet> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<DerivedEventFormData> _formDataList;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _formDataList = widget.selectedTypes.map((t) => DerivedEventFormData(t)).toList();
    _tabController = TabController(length: _formDataList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _saveAll() async {
    // Validate all forms
    List<String> invalidTabs = [];
    for (int i = 0; i < _formDataList.length; i++) {
      final data = _formDataList[i];
      final bool isValid = data.formKey.currentState?.validate() ?? data.isComplete;
      if (!isValid || (data.isCustom && data.finalEventType == null)) {
        invalidTabs.add(data.isCustom ? 'Personalizado ${i + 1}' : data.type!.name);
      }
    }

    if (invalidTabs.isNotEmpty) {
      final bool? continueSaving = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Eventos incompletos'),
          content: Text('Los siguientes eventos no han sido rellenados correctamente:\n\n'
              '${invalidTabs.join('\n')}\n\n'
              'Si continúas, estos eventos no se generarán. ¿Deseas continuar?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Continuar')),
          ],
        ),
      );

      if (continueSaving != true) return;
    }

    setState(() => _isLoading = true);

    try {
      final repo = ref.read(healthRepositoryProvider);
      
      for (final data in _formDataList) {
        final bool isValid = data.formKey.currentState?.validate() ?? data.isComplete;
        if (!isValid || (data.isCustom && data.finalEventType == null)) {
          continue; // Skip invalid forms
        }
        
        data.formKey.currentState?.save();
        
        HealthEventDto dto;
        final eventType = data.finalEventType!;
        final typeName = eventType.name.toLowerCase();

        if (typeName.contains('visita')) {
          dto = HealthEventDto.vetVisit(
            id: '00000000-0000-0000-0000-000000000000',
            petId: widget.petId,
            eventType: eventType,
            date: data.date,
            title: data.title,
            notes: data.notes.isEmpty ? null : data.notes,
            parentId: widget.parentId,
            clinicName: data.clinicName.isEmpty ? null : data.clinicName,
            veterinarianName: data.vetName.isEmpty ? null : data.vetName,
            isHospitalization: data.isHospitalization,
          );
        } else if (typeName.contains('medic')) {
          dto = HealthEventDto.medication(
            id: '00000000-0000-0000-0000-000000000000',
            petId: widget.petId,
            eventType: eventType,
            date: data.date,
            title: data.title,
            notes: data.notes.isEmpty ? null : data.notes,
            parentId: widget.parentId,
            drugName: data.drugName,
            dosage: data.dosage,
            frequencyValue: data.isRecurring ? data.frequencyValue : 0,
            frequencyUnit: data.frequencyUnit,
            startDate: data.date,
          );
        } else if (typeName.contains('vacun')) {
          dto = HealthEventDto.vaccine(
            id: '00000000-0000-0000-0000-000000000000',
            petId: widget.petId,
            eventType: eventType,
            date: data.date,
            title: data.title,
            notes: data.notes.isEmpty ? null : data.notes,
            parentId: widget.parentId,
            vaccineName: data.vaccineName,
            frequencyValue: data.isRecurring ? data.frequencyValue : 0,
            frequencyUnit: data.frequencyUnit,
          );
        } else {
          dto = HealthEventDto.custom(
            id: '00000000-0000-0000-0000-000000000000',
            petId: widget.petId,
            eventType: eventType,
            date: data.date,
            title: data.title,
            notes: data.notes.isEmpty ? null : data.notes,
            frequencyValue: data.isRecurring ? data.frequencyValue : 0,
            frequencyUnit: data.frequencyUnit,
            parentId: widget.parentId,
          );
        }

        await repo.createHealthEvent(widget.petId, dto);
      }
      
      ref.invalidate(healthAgendaProvider);
      
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eventTypes = ref.watch(eventTypesProvider).whenOrNull(data: (d) => d) ?? [];
    final customTypes = eventTypes.where((t) => t.userId != null).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Nuevos Eventos Derivados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _tabController,
            builder: (context, _) {
              // Group data by type ID or 'custom'
              final Map<String, List<int>> groups = {};
              for (int i = 0; i < _formDataList.length; i++) {
                final String groupId = _formDataList[i].isCustom ? 'custom' : _formDataList[i].type!.id;
                groups.putIfAbsent(groupId, () => []).add(i);
              }

              final currentData = _formDataList[_tabController.index];
              final currentGroupId = currentData.isCustom ? 'custom' : currentData.type!.id;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      children: groups.entries.map((entry) {
                        final groupId = entry.key;
                        final indices = entry.value;
                        final isGroupSelected = groupId == currentGroupId;
                        
                        final firstData = _formDataList[indices.first];
                        
                        IconData iconData = Icons.star;
                        Color color = Colors.purple;
                        if (!firstData.isCustom && firstData.type != null) {
                          if (firstData.type!.icon == 'local_hospital') iconData = Icons.local_hospital;
                          if (firstData.type!.icon == 'medication') iconData = Icons.medication;
                          if (firstData.type!.icon == 'vaccines') iconData = Icons.vaccines;
                          
                          if (firstData.type!.color == 'blue') color = Colors.blue;
                          if (firstData.type!.color == 'orange') color = Colors.orange;
                          if (firstData.type!.color == 'red') color = Colors.red;
                        }

                        final bool isGroupComplete = indices.every((i) => _formDataList[i].isComplete);

                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ActionChip(
                            avatar: Icon(isGroupComplete ? Icons.check_circle : iconData, color: isGroupSelected ? Colors.white : color, size: 18),
                            label: Text(
                              '${firstData.isCustom ? 'Personalizado' : firstData.type!.name}${indices.length > 1 ? ' (${indices.length})' : ''}',
                              style: TextStyle(
                                color: isGroupSelected ? Colors.white : theme.colorScheme.onSurface,
                                fontWeight: isGroupSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            backgroundColor: isGroupSelected ? color : (isGroupComplete ? color.withValues(alpha: 0.2) : color.withValues(alpha: 0.05)),
                            side: BorderSide(color: isGroupSelected ? color : (isGroupComplete ? color : color.withValues(alpha: 0.3))),
                            onPressed: () {
                              if (!isGroupSelected) {
                                _tabController.animateTo(indices.first);
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  
                  if (groups[currentGroupId]!.length > 1)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 12.0),
                      child: Row(
                        children: groups[currentGroupId]!.asMap().entries.map((subEntry) {
                          final subIndex = subEntry.key;
                          final globalIndex = subEntry.value;
                          final data = _formDataList[globalIndex];
                          final isSelected = _tabController.index == globalIndex;

                          Color color = data.isCustom ? Colors.purple : theme.colorScheme.primary;
                          if (!data.isCustom && data.type != null) {
                            if (data.type!.color == 'blue') color = Colors.blue;
                            if (data.type!.color == 'orange') color = Colors.orange;
                            if (data.type!.color == 'red') color = Colors.red;
                          }

                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              label: Text('${data.isCustom ? 'Pers.' : data.type!.name} ${subIndex + 1}'),
                              selected: isSelected,
                              selectedColor: color.withValues(alpha: 0.2),
                              labelStyle: TextStyle(
                                color: isSelected ? color : theme.colorScheme.onSurfaceVariant,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                              avatar: data.isComplete ? Icon(Icons.check, color: color, size: 16) : null,
                              onSelected: (selected) {
                                if (selected) _tabController.animateTo(globalIndex);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              );
            },
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _formDataList.map((data) {
                return _buildForm(data, customTypes, theme);
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16)),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: _isLoading ? null : _saveAll,
                    style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
                    child: _isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Guardar General'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(DerivedEventFormData data, List<EventTypeDefinitionDto> customTypes, ThemeData theme) {
    return Form(
      key: data.formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (data.isCustom) ...[
            if (customTypes.isEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('No tienes eventos personalizados creados.'),
              )
            else
              DropdownButtonFormField<EventTypeDefinitionDto>(
                value: data.finalEventType,
                decoration: const InputDecoration(labelText: 'Tipo de Evento Personalizado', border: OutlineInputBorder()),
                items: customTypes.map((t) => DropdownMenuItem(value: t, child: Text(t.name))).toList(),
                onChanged: (val) {
                  setState(() => data.finalEventType = val);
                },
                validator: (val) => val == null ? 'Selecciona un tipo' : null,
              ),
            const SizedBox(height: 16),
          ],
          
          TextFormField(
            initialValue: data.title,
            decoration: const InputDecoration(labelText: 'Título', border: OutlineInputBorder()),
            onChanged: (val) {
              data.title = val;
              setState(() {});
            },
            validator: (val) => val == null || val.isEmpty ? 'Requerido' : null,
          ),
          const SizedBox(height: 16),
          
          ListTile(
            title: const Text('Fecha y Hora'),
            subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(data.date)),
            trailing: const Icon(Icons.calendar_today),
            shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(4)),
            onTap: () async {
              final d = await showDatePicker(context: context, initialDate: data.date, firstDate: DateTime(2000), lastDate: DateTime(2100));
              if (d != null) {
                if (!mounted) return;
                final t = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(data.date));
                if (t != null) {
                  setState(() => data.date = DateTime(d.year, d.month, d.day, t.hour, t.minute));
                }
              }
            },
          ),
          const SizedBox(height: 16),
          
          // Campos específicos
          if (data.finalEventType?.name.toLowerCase().contains('visita') == true) ...[
            TextFormField(
              initialValue: data.clinicName,
              decoration: const InputDecoration(labelText: 'Clínica', border: OutlineInputBorder()),
              onChanged: (val) {
                data.clinicName = val;
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: data.vetName,
              decoration: const InputDecoration(labelText: 'Veterinario', border: OutlineInputBorder()),
              onChanged: (val) {
                data.vetName = val;
                setState(() {});
              },
            ),
            CheckboxListTile(
              title: const Text('¿Requiere Hospitalización?'),
              value: data.isHospitalization,
              onChanged: (val) => setState(() => data.isHospitalization = val ?? false),
            ),
          ] else if (data.finalEventType?.name.toLowerCase().contains('medic') == true) ...[
             TextFormField(
              initialValue: data.drugName,
              decoration: const InputDecoration(labelText: 'Nombre del Medicamento', border: OutlineInputBorder()),
              onChanged: (val) {
                data.drugName = val;
                setState(() {});
              },
              validator: (val) => val == null || val.isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 16),
             TextFormField(
              initialValue: data.dosage,
              decoration: const InputDecoration(labelText: 'Dosis (ej: 1 Pastilla)', border: OutlineInputBorder()),
              onChanged: (val) {
                data.dosage = val;
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('¿Es un evento repetitivo?'),
              value: data.isRecurring,
              onChanged: (val) => setState(() => data.isRecurring = val),
              contentPadding: EdgeInsets.zero,
            ),
            if (data.isRecurring) _buildFrequencyFields(data),
          ] else if (data.finalEventType?.name.toLowerCase().contains('vacun') == true) ...[
             TextFormField(
              initialValue: data.vaccineName,
              decoration: const InputDecoration(labelText: 'Nombre de la Vacuna', border: OutlineInputBorder()),
              onChanged: (val) {
                data.vaccineName = val;
                setState(() {});
              },
              validator: (val) => val == null || val.isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('¿Es un evento repetitivo?'),
              value: data.isRecurring,
              onChanged: (val) => setState(() => data.isRecurring = val),
              contentPadding: EdgeInsets.zero,
            ),
            if (data.isRecurring) _buildFrequencyFields(data),
          ] else if (data.isCustom) ...[
            SwitchListTile(
              title: const Text('¿Es un evento repetitivo?'),
              value: data.isRecurring,
              onChanged: (val) => setState(() => data.isRecurring = val),
              contentPadding: EdgeInsets.zero,
            ),
            if (data.isRecurring) _buildFrequencyFields(data),
          ],
          
          const SizedBox(height: 16),
          TextFormField(
            initialValue: data.notes,
            decoration: const InputDecoration(labelText: 'Notas Adicionales', border: OutlineInputBorder()),
            maxLines: 3,
            onChanged: (val) {
              data.notes = val;
              setState(() {});
            },
          ),
          const SizedBox(height: 100), // padding bottom
        ],
      ),
    );
  }

  Widget _buildFrequencyFields(DerivedEventFormData data) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextFormField(
            initialValue: data.frequencyValue.toString(),
            decoration: const InputDecoration(labelText: 'Frecuencia', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            onChanged: (val) => data.frequencyValue = int.tryParse(val) ?? 1,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: DropdownButtonFormField<int>(
            value: data.frequencyUnit,
            decoration: const InputDecoration(labelText: 'Unidad', border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(value: 0, child: Text('Horas')),
              DropdownMenuItem(value: 1, child: Text('Días')),
              DropdownMenuItem(value: 2, child: Text('Meses')),
              DropdownMenuItem(value: 3, child: Text('Años')),
            ],
            onChanged: (val) {
              if (val != null) setState(() => data.frequencyUnit = val);
            },
          ),
        ),
      ],
    );
  }
}
