// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_type_definition_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventTypeDefinitionDto _$EventTypeDefinitionDtoFromJson(
  Map<String, dynamic> json,
) => _EventTypeDefinitionDto(
  id: json['id'] as String,
  userId: json['userId'] as String?,
  name: json['name'] as String,
  icon: json['icon'] as String?,
  color: json['color'] as String?,
);

Map<String, dynamic> _$EventTypeDefinitionDtoToJson(
  _EventTypeDefinitionDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'name': instance.name,
  'icon': instance.icon,
  'color': instance.color,
};
