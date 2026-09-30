import 'package:flutter/material.dart';
import '../../domain/pet_dto.dart';
import '../../domain/pet_avatar_helper.dart';

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
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 110,
        decoration: BoxDecoration(
          color: isSelected 
              ? theme.colorScheme.primaryContainer 
              : (isDark ? theme.colorScheme.surfaceContainerHighest : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected 
                ? theme.colorScheme.primary 
                : theme.colorScheme.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ] : [],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: theme.colorScheme.surfaceContainer,
              backgroundImage: AssetImage(getPetAvatarPath(pet.species, pet.photoUrl)),
            ),
            const SizedBox(height: 8),
            Text(
              pet.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurface,
              ),
            ),
            if (pet.breed != null && pet.breed!.isNotEmpty)
              Text(
                pet.breed!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected ? theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8) : theme.colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }
}