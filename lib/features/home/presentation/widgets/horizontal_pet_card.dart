import 'package:flutter/material.dart';
import '../../../pets/domain/pet_avatar_helper.dart';
import '../../../pets/domain/pet_dto.dart';

class HorizontalPetCard extends StatelessWidget {
  final PetDto pet;
  final bool isSelected;
  final VoidCallback onTap;

  const HorizontalPetCard({
    super.key,
    required this.pet,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isFemale = pet.photoUrl?.toLowerCase().trim() == 'hembra';
    final avatarPath = getPetAvatarPath(pet.species, pet.photoUrl);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: 110,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? theme.colorScheme.primaryContainer.withAlpha(50)
            : theme.cardTheme.color ?? Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? theme.colorScheme.primary : Colors.grey.shade300,
          width: isSelected ? 2.5 : 1.0,
        ),
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: theme.colorScheme.primary.withAlpha(60),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          else
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Avatar con insignia de selección si aplica
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                        border: Border.all(
                          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          avatarPath,
                          width: 58,
                          height: 58,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.pets,
                              size: 30,
                              color: theme.colorScheme.primary,
                            );
                          },
                        ),
                      ),
                    ),
                    if (isSelected)
                      Positioned(
                        right: -4,
                        bottom: -4,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                // Nombre de la mascota
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        pet.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          color: isSelected ? theme.colorScheme.primary : null,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Icon(
                      isFemale ? Icons.female : Icons.male,
                      size: 13,
                      color: isFemale ? Colors.pink.shade400 : Colors.blue.shade600,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                // Especie
                Text(
                  pet.species,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

