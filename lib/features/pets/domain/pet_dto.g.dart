// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PetDto _$PetDtoFromJson(Map<String, dynamic> json) => _PetDto(
  id: json['id'] as String,
  name: json['name'] as String,
  species: json['species'] as String,
  breed: json['breed'] as String?,
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
  photoUrl: json['photoUrl'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$PetDtoToJson(_PetDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'species': instance.species,
  'breed': instance.breed,
  'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
  'photoUrl': instance.photoUrl,
  'createdAt': instance.createdAt.toIso8601String(),
};

_CreatePetDto _$CreatePetDtoFromJson(Map<String, dynamic> json) =>
    _CreatePetDto(
      name: json['name'] as String,
      species: json['species'] as String,
      breed: json['breed'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$CreatePetDtoToJson(_CreatePetDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'species': instance.species,
      'breed': instance.breed,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'photoUrl': instance.photoUrl,
    };
