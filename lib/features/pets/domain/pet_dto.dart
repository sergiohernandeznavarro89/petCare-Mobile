import 'package:freezed_annotation/freezed_annotation.dart';

part 'pet_dto.freezed.dart';
part 'pet_dto.g.dart';

@freezed
abstract class PetDto with _$PetDto {
  const factory PetDto({
    required String id,
    required String name,
    required String species,
    String? breed,
    DateTime? dateOfBirth,
    String? photoUrl,
    required DateTime createdAt,
  }) = _PetDto;

  factory PetDto.fromJson(Map<String, dynamic> json) => _$PetDtoFromJson(json);
}

@freezed
abstract class CreatePetDto with _$CreatePetDto {
  const factory CreatePetDto({
    required String name,
    required String species,
    String? breed,
    DateTime? dateOfBirth,
    String? photoUrl,
  }) = _CreatePetDto;

  factory CreatePetDto.fromJson(Map<String, dynamic> json) => _$CreatePetDtoFromJson(json);
}
