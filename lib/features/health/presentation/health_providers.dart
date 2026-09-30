import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/health_event_dto.dart';
import '../domain/health_event_occurrence_dto.dart';
import '../domain/event_type_definition_dto.dart';
import '../data/health_repository.dart';
import '../../pets/presentation/pets_provider.dart';

part 'health_providers.g.dart';

// --- Event Types Provider ---
final eventTypesProvider = FutureProvider.autoDispose<List<EventTypeDefinitionDto>>((ref) async {
  final repository = ref.watch(healthRepositoryProvider);
  return repository.getEventTypes();
});

@riverpod
class HealthAgenda extends _$HealthAgenda {
  int _skip = 0;
  final int _take = 20;
  bool _hasMore = true;

  @override
  Future<List<HealthEventOccurrenceDto>> build() async {
    _skip = 0;
    _hasMore = true;
    final repository = ref.watch(healthRepositoryProvider);
    final selectedPet = ref.watch(selectedPetProvider);
    final initialItems = await repository.getAgenda(petId: selectedPet?.id, skip: _skip, take: _take);
    if (initialItems.length < _take) {
      _hasMore = false;
    }
    return initialItems;
  }

  Future<void> fetchNextPage() async {
    if (!_hasMore) return;
    _skip += _take;
    
    try {
      final repository = ref.read(healthRepositoryProvider);
      final selectedPet = ref.read(selectedPetProvider);
      
      final newItems = await repository.getAgenda(petId: selectedPet?.id, skip: _skip, take: _take);
      if (newItems.length < _take) {
        _hasMore = false;
      }
      
      final currentList = state.value ?? [];
      state = AsyncValue.data([...currentList, ...newItems]);
    } catch (e, st) {
      // Handle error
    }
  }

  void removeOccurrenceLocally(String id) {
    if (state.value != null) {
      final newList = state.value!.where((e) => e.id != id).toList();
      state = AsyncValue.data(newList);
    }
  }
}

// --- Health History Provider (Timeline Screen) ---
final healthHistoryProvider = FutureProvider.autoDispose.family<List<HealthEventDto>, String>((ref, petId) async {
  final repository = ref.watch(healthRepositoryProvider);
  final events = await repository.getHistory(petId);
  
  final sortedEvents = List<HealthEventDto>.from(events);
  sortedEvents.sort((a, b) => b.date.compareTo(a.date));
  return sortedEvents;
});