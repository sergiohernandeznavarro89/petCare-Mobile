import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../domain/pet_dto.dart';
import 'pets_provider.dart';
import 'widgets/pet_form_bottom_sheet.dart';

class PetsListScreen extends ConsumerWidget {
  const PetsListScreen({super.key});

  void _showAddPetForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PetFormBottomSheet(),
    );
  }

  void _showEditPetForm(BuildContext context, PetDto pet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PetFormBottomSheet(petToEdit: pet),
    );
  }

  Future<bool> _confirmDeletePet(BuildContext context, WidgetRef ref, PetDto pet) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red.shade600, size: 28),
            const SizedBox(width: 10),
            Expanded(child: Text('¿Eliminar a ${pet.name}?')),
          ],
        ),
        content: Text(
          '¿Estás seguro de que deseas eliminar a ${pet.name}? Esta acción no se puede deshacer y se borrarán todos sus registros.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(petsProvider.notifier).deletePet(pet.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(child: Text('¡${pet.name} ha sido eliminado!')),
                ],
              ),
              backgroundColor: Colors.red.shade700,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
        return true;
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al eliminar: $e'),
              backgroundColor: Colors.red.shade800,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
        return false;
      }
    }
    return false;
  }

  String _getAvatarPath(String species, String? photoUrlOrGender) {
    final isFemale = (photoUrlOrGender?.toLowerCase().trim() == 'hembra');
    final suffix = isFemale ? 'female' : 'male';
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

  Color _getSpeciesColor(String species) {
    switch (species.toLowerCase().trim()) {
      case 'perro':
        return Colors.orange.shade700;
      case 'gato':
        return Colors.purple.shade600;
      case 'ave':
        return Colors.teal.shade600;
      case 'reptil':
        return Colors.green.shade700;
      default:
        return Colors.blueGrey;
    }
  }

  String? _calculateAge(DateTime? dob) {
    if (dob == null) return null;
    final now = DateTime.now();
    int years = now.year - dob.year;
    int months = now.month - dob.month;
    if (now.day < dob.day) months--;
    if (months < 0) {
      years--;
      months += 12;
    }
    if (years > 0) {
      return years == 1 ? '1 año' : '$years años';
    }
    if (months > 0) {
      return months == 1 ? '1 mes' : '$months meses';
    }
    return 'Cachorro';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petsState = ref.watch(petsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Mascotas'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(petsProvider.notifier).refreshPets(),
        child: petsState.when(
          data: (pets) {
            if (pets.isEmpty) {
              return LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.primaryContainer.withAlpha(80),
                              ),
                              child: Icon(
                                Icons.pets,
                                size: 64,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Aún no tienes mascotas registradas',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Pulsa el botón "+" abajo para añadir a tu primer compañero.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () => _showAddPetForm(context),
                              icon: const Icon(Icons.add),
                              label: const Text('Añadir Mascota'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: pets.length,
              itemBuilder: (context, index) {
                final pet = pets[index];
                final isFemale = pet.photoUrl?.toLowerCase().trim() == 'hembra';
                final avatarPath = _getAvatarPath(pet.species, pet.photoUrl);
                final speciesColor = _getSpeciesColor(pet.species);
                final ageText = _calculateAge(pet.dateOfBirth);

                return Dismissible(
                  key: Key('pet_${pet.id}'),
                  direction: DismissDirection.horizontal,
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      // Deslizar a la derecha -> Editar
                      _showEditPetForm(context, pet);
                      return false;
                    } else if (direction == DismissDirection.endToStart) {
                      // Deslizar a la izquierda -> Borrar con confirmación
                      return await _confirmDeletePet(context, ref, pet);
                    }
                    return false;
                  },
                  // Fondo al deslizar a la derecha (Editar)
                  background: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withAlpha(200),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.edit, color: Colors.white, size: 26),
                        SizedBox(width: 10),
                        Text(
                          'Editar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Fondo al deslizar a la izquierda (Eliminar)
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.red.shade600,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Eliminar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.delete_outline, color: Colors.white, size: 26),
                      ],
                    ),
                  ),
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => _showEditPetForm(context, pet),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: [
                            // Avatar circular según especie y género
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200,
                                boxShadow: [
                                  BoxShadow(
                                    color: (isFemale ? Colors.pink : Colors.blue).withAlpha(30),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  avatarPath,
                                  width: 72,
                                  height: 72,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.pets,
                                      size: 38,
                                      color: speciesColor,
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Información de la mascota
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          pet.name,
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      // Icono de Género
                                      Icon(
                                        isFemale ? Icons.female : Icons.male,
                                        size: 18,
                                        color: isFemale ? Colors.pink.shade400 : Colors.blue.shade600,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: speciesColor.withAlpha(30),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: speciesColor.withAlpha(60), width: 0.8),
                                        ),
                                        child: Text(
                                          pet.species,
                                          style: TextStyle(
                                            color: speciesColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      if (pet.breed != null && pet.breed!.isNotEmpty) ...[
                                        const SizedBox(width: 6),
                                        Flexible(
                                          child: Text(
                                            pet.breed!,
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color: Colors.grey.shade700,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  // Fecha de Nacimiento / Edad
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.cake_outlined,
                                        size: 14,
                                        color: pet.dateOfBirth != null ? Colors.pink.shade300 : Colors.grey.shade400,
                                      ),
                                      const SizedBox(width: 5),
                                      if (pet.dateOfBirth != null) ...[
                                        if (ageText != null) ...[
                                          Text(
                                            ageText,
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: Colors.grey.shade700,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            '(${DateFormat('dd/MM/yyyy').format(pet.dateOfBirth!.toLocal())})',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 11.5,
                                                ),
                                          ),
                                        ] else ...[
                                          Text(
                                            DateFormat('dd/MM/yyyy').format(pet.dateOfBirth!.toLocal()),
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: Colors.grey.shade700,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ],
                                      ] else ...[
                                        Text(
                                          'Sin fecha de nacimiento',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: Colors.grey.shade400,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 11.5,
                                              ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Cargando mascotas...'),
              ],
            ),
          ),
          error: (error, stack) => LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red, size: 48),
                        const SizedBox(height: 16),
                        Text(
                          'No se pudieron cargar tus mascotas',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$error',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () => ref.read(petsProvider.notifier).refreshPets(),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPetForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
