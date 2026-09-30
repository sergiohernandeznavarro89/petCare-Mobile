import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/dio_client.dart';
import '../domain/pet_dto.dart';

part 'pet_repository.g.dart';

class PetRepository {
  final Dio _dio;

  PetRepository(this._dio);

  Future<List<PetDto>> getPets() async {
    final response = await _dio.get('/pets');
    final data = response.data;
    if (data is List) {
      return data.map((json) => PetDto.fromJson(json as Map<String, dynamic>)).toList();
    }
    return [];
  }

  Future<PetDto> createPet(CreatePetDto dto) async {
    final response = await _dio.post('/pets', data: dto.toJson());
    return PetDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> updatePet(String id, CreatePetDto dto) async {
    await _dio.put('/pets/$id', data: dto.toJson());
  }

  Future<void> deletePet(String id) async {
    await _dio.delete('/pets/$id');
  }
}

@riverpod
PetRepository petRepository(Ref ref) {
  return PetRepository(ref.watch(dioProvider));
}
