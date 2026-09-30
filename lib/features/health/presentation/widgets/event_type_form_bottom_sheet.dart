import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/event_type_definition_dto.dart';
import '../health_providers.dart';
import '../../data/health_repository.dart';

class EventTypeFormBottomSheet extends ConsumerStatefulWidget {
  final EventTypeDefinitionDto? typeToEdit;

  const EventTypeFormBottomSheet({super.key, this.typeToEdit});

  @override
  ConsumerState<EventTypeFormBottomSheet> createState() => _EventTypeFormBottomSheetState();
}

class _EventTypeFormBottomSheetState extends ConsumerState<EventTypeFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  
  String _selectedIcon = 'star';
  String _selectedColor = 'purple';
  bool _isSubmitting = false;

  final List<String> _icons = ['star', 'favorite', 'pets', 'healing', 'spa'];
  final List<String> _colors = ['purple', 'blue', 'green', 'orange', 'red', 'teal', 'pink', 'indigo', 'amber', 'cyan'];

  bool get _isEditing => widget.typeToEdit != null;

  @override
  void initState() {
    super.initState();
    final type = widget.typeToEdit;
    _nameController = TextEditingController(text: type?.name ?? '');
    if (type != null) {
      _selectedIcon = type.icon ?? 'star';
      _selectedColor = type.color ?? 'purple';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final name = _nameController.text.trim();
      final dto = EventTypeDefinitionDto(
        id: widget.typeToEdit?.id ?? '',
        userId: '',
        name: name,
        icon: _selectedIcon,
        color: _selectedColor,
      );

      final repo = ref.read(healthRepositoryProvider);
      if (_isEditing) {
        await repo.updateEventType(dto.id, dto); ref.invalidate(eventTypesProvider);
      } else {
        await repo.createEventType(dto); ref.invalidate(eventTypesProvider);
      }
      
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'favorite': return Icons.favorite;
      case 'pets': return Icons.pets;
      case 'healing': return Icons.healing;
      case 'spa': return Icons.spa;
      case 'star': default: return Icons.star;
    }
  }

  Color _getColorValue(String name) {
    switch (name) {
      case 'blue': return Colors.blue;
      case 'green': return Colors.green;
      case 'orange': return Colors.orange;
      case 'red': return Colors.red;
      case 'teal': return Colors.teal;
      case 'pink': return Colors.pink;
      case 'indigo': return Colors.indigo;
      case 'amber': return Colors.amber;
      case 'cyan': return Colors.cyan;
      case 'purple': default: return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.9,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _isEditing ? 'Editar Evento Personalizado' : 'Nuevo Evento Personalizado',
                          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(20),
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nombre del Evento',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.edit),
                          ),
                          validator: (val) => val == null || val.trim().isEmpty ? 'Requerido' : null,
                        ),
                        const SizedBox(height: 24),
                        Text('Selecciona un icono', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: _icons.map((iconName) {
                            final isSelected = _selectedIcon == iconName;
                            return InkWell(
                              onTap: () => setState(() => _selectedIcon = iconName),
                              borderRadius: BorderRadius.circular(12),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isSelected ? theme.colorScheme.primaryContainer : (isDark ? theme.colorScheme.surfaceContainerHighest : Colors.grey.shade100),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: isSelected ? theme.colorScheme.primary : Colors.transparent, width: 2),
                                ),
                                child: Icon(_getIconData(iconName), color: isSelected ? theme.colorScheme.primary : Colors.grey.shade600),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                        Text('Selecciona un color', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: _colors.map((colorName) {
                            final isSelected = _selectedColor == colorName;
                            final c = _getColorValue(colorName);
                            return InkWell(
                              onTap: () => setState(() => _selectedColor = colorName),
                              borderRadius: BorderRadius.circular(24),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: c,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: isSelected ? theme.colorScheme.onSurface : Colors.transparent, width: 3),
                                  boxShadow: isSelected ? [BoxShadow(color: c.withValues(alpha: 0.4), blurRadius: 8, spreadRadius: 2)] : [],
                                ),
                                child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: _isSubmitting ? null : _submit,
                          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                          child: _isSubmitting ? const CircularProgressIndicator() : const Text('Guardar Evento'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}