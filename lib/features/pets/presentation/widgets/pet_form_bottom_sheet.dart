import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../../domain/pet_dto.dart';
import '../pets_provider.dart';

class PetFormBottomSheet extends ConsumerStatefulWidget {
  final PetDto? petToEdit;

  const PetFormBottomSheet({super.key, this.petToEdit});

  @override
  ConsumerState<PetFormBottomSheet> createState() => _PetFormBottomSheetState();
}

class _PetFormBottomSheetState extends ConsumerState<PetFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _breedController;
  late final TextEditingController _dateController;

  final List<String> _speciesOptions = ['Perro', 'Gato', 'Ave', 'Reptil', 'Otro'];
  late String _selectedSpecies;
  late String _selectedGender;
  DateTime? _selectedDate;
  bool _isSubmitting = false;

  bool get _isEditing => widget.petToEdit != null;

  @override
  void initState() {
    super.initState();
    final pet = widget.petToEdit;
    if (pet != null) {
      _nameController = TextEditingController(text: pet.name);
      _breedController = TextEditingController(text: pet.breed ?? '');
      _selectedSpecies = _speciesOptions.contains(pet.species) ? pet.species : _speciesOptions.first;
      _selectedGender = (pet.photoUrl?.toLowerCase().trim() == 'hembra') ? 'Hembra' : 'Macho';
      _selectedDate = pet.dateOfBirth;
      _dateController = TextEditingController(
        text: _selectedDate != null ? DateFormat('dd/MM/yyyy').format(_selectedDate!) : '',
      );
    } else {
      _nameController = TextEditingController();
      _breedController = TextEditingController();
      _dateController = TextEditingController();
      _selectedSpecies = _speciesOptions.first;
      _selectedGender = 'Macho';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  String _getAvatarAsset(String species, String gender) {
    final suffix = (gender == 'Hembra') ? 'female' : 'male';
    switch (species.toLowerCase().trim()) {
      case 'perro':
        return 'assets/images/avatars/dog_$suffix.jpg';
      case 'gato':
        return 'assets/images/avatars/cat_$suffix.jpg';
      case 'ave':
        return 'assets/images/avatars/bird_$suffix.jpg';
      case 'reptil':
        return 'assets/images/avatars/reptile_$suffix.jpg';
      default:
        return 'assets/images/avatars/other_$suffix.jpg';
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
      helpText: 'Selecciona la fecha de nacimiento',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    final name = _nameController.text.trim();
    final breed = _breedController.text.trim().isEmpty ? null : _breedController.text.trim();

    try {
      final dto = CreatePetDto(
        name: name,
        species: _selectedSpecies,
        breed: breed,
        dateOfBirth: _selectedDate,
        photoUrl: _selectedGender,
      );

      if (_isEditing) {
        await ref.read(petsProvider.notifier).updatePet(widget.petToEdit!.id, dto);
      } else {
        await ref.read(petsProvider.notifier).addPet(dto);
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _isEditing
                        ? '¡$name ha sido actualizado con éxito!'
                        : '¡$name ha sido guardado correctamente!',
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        String errorMsg = e.toString();
        if (e is DioException) {
          errorMsg = e.response?.data?.toString() ?? e.message ?? 'Error de conexión';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(child: Text('Error al guardar: $errorMsg')),
              ],
            ),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final avatarKey = '$_selectedSpecies-$_selectedGender';
    final currentAvatarPath = _getAvatarAsset(_selectedSpecies, _selectedGender);

    return Container(
      padding: EdgeInsets.only(
        bottom: bottomPadding + 24.0,
        left: 24.0,
        right: 24.0,
        top: 16.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(76),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Avatar animado dependiente de Especie + Género
              Center(
                child: TweenAnimationBuilder<double>(
                  key: ValueKey(avatarKey),
                  tween: Tween(begin: 0.5, end: 1.0),
                  duration: const Duration(milliseconds: 320),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Container(
                        width: 95,
                        height: 95,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                          boxShadow: [
                            BoxShadow(
                              color: (_selectedGender == 'Hembra' ? Colors.pink : Colors.blue).withAlpha(45),
                              blurRadius: 14,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            currentAvatarPath,
                            width: 95,
                            height: 95,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.pets,
                                size: 50,
                                color: Theme.of(context).colorScheme.primary,
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _isEditing ? 'Editar Mascota' : 'Nueva Mascota',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 20),

              // Selector de Género (Macho / Hembra)
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment<String>(
                    value: 'Macho',
                    label: Text('Macho', style: TextStyle(fontWeight: FontWeight.w600)),
                    icon: Icon(Icons.male, color: Colors.blue),
                  ),
                  ButtonSegment<String>(
                    value: 'Hembra',
                    label: Text('Hembra', style: TextStyle(fontWeight: FontWeight.w600)),
                    icon: Icon(Icons.female, color: Colors.pink),
                  ),
                ],
                selected: {_selectedGender},
                onSelectionChanged: _isSubmitting
                    ? null
                    : (Set<String> newSelection) {
                        setState(() {
                          _selectedGender = newSelection.first;
                        });
                      },
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Nombre
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.pets),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Introduce el nombre' : null,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),

              // Especie
              DropdownButtonFormField<String>(
                initialValue: _selectedSpecies,
                decoration: const InputDecoration(
                  labelText: 'Especie',
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                items: _speciesOptions.map((String species) {
                  return DropdownMenuItem<String>(
                    value: species,
                    child: Text(species),
                  );
                }).toList(),
                onChanged: _isSubmitting
                    ? null
                    : (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedSpecies = newValue;
                          });
                        }
                      },
              ),
              const SizedBox(height: 16),

              // Raza
              TextFormField(
                controller: _breedController,
                decoration: const InputDecoration(
                  labelText: 'Raza (Opcional)',
                  prefixIcon: Icon(Icons.star_border),
                ),
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),

              // Fecha de Nacimiento
              TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: _isSubmitting ? null : _pickDate,
                decoration: InputDecoration(
                  labelText: 'Fecha de Nacimiento (Opcional)',
                  prefixIcon: const Icon(Icons.cake_outlined),
                  suffixIcon: _selectedDate != null
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () {
                            setState(() {
                              _selectedDate = null;
                              _dateController.clear();
                            });
                          },
                        )
                      : const Icon(Icons.calendar_month),
                ),
              ),
              const SizedBox(height: 28),

              // Botón Guardar / Actualizar
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                      )
                    : Text(
                        _isEditing ? 'Actualizar Mascota' : 'Guardar Mascota',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
