import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_type_definition_dto.freezed.dart';
part 'event_type_definition_dto.g.dart';

@freezed
abstract class EventTypeDefinitionDto with _$EventTypeDefinitionDto {
  const factory EventTypeDefinitionDto({
    required String id,
    String? userId,
    required String name,
    String? icon,
    String? color,
  }) = _EventTypeDefinitionDto;

  factory EventTypeDefinitionDto.fromJson(Map<String, dynamic> json) =>
      _$EventTypeDefinitionDtoFromJson(json);
}