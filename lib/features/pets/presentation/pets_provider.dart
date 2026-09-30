import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/pet_repository.dart';
import '../domain/pet_dto.dart';

part 'pets_provider.g.dart';

@riverpod
class PetsNotifier extends _$PetsNotifier {
  @override
  FutureOr<List<PetDto>> build() async {
    return _fetchPets();
  }

  Future<List<PetDto>> _fetchPets() async {
    final repo = ref.read(petRepositoryProvider);
    return await repo.getPets();
  }

  Future<void> addPet(CreatePetDto dto) async {
    final repo = ref.read(petRepositoryProvider);
    await repo.createPet(dto);
    ref.invalidateSelf();
    await future;
  }

  Future<void> updatePet(String id, CreatePetDto dto) async {
    final repo = ref.read(petRepositoryProvider);
    await repo.updatePet(id, dto);
    ref.invalidateSelf();
    await future;
  }

  Future<void> deletePet(String id) async {
    final repo = ref.read(petRepositoryProvider);
    await repo.deletePet(id);
    ref.invalidateSelf();
    await future;
  }

  Future<void> refreshPets() async {
    ref.invalidateSelf();
    await future;
  }
}

// Provider para la mascota seleccionada en Home (por defecto null)
final selectedPetProvider = NotifierProvider<SelectedPetNotifier, PetDto?>(SelectedPetNotifier.new);

class SelectedPetNotifier extends Notifier<PetDto?> {
  @override
  PetDto? build() => null;

  void toggle(PetDto pet) {
    if (state?.id == pet.id) {
      state = null; // Si se vuelve a pulsar la misma, se deselecciona
    } else {
      state = pet;
    }
  }

  void select(PetDto? pet) {
    state = pet;
  }
}

final effectivePetProvider = Provider<PetDto?>((ref) {
  final explicit = ref.watch(selectedPetProvider);
  if (explicit != null) return explicit;
  
  final petsAsync = ref.watch(petsProvider);
  return petsAsync.maybeWhen(
    data: (pets) => pets.isNotEmpty ? pets.first : null,
    orElse: () => null,
  );
});