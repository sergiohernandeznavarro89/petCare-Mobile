// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_event_occurrence_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HealthEventOccurrenceDto _$HealthEventOccurrenceDtoFromJson(
  Map<String, dynamic> json,
) => _HealthEventOccurrenceDto(
  id: json['id'] as String,
  healthEventId: json['healthEventId'] as String,
  scheduledDate: DateTime.parse(json['scheduledDate'] as String),
  status: json['status'] as String,
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  healthEvent: json['healthEvent'] == null
      ? null
      : HealthEventDto.fromJson(json['healthEvent'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HealthEventOccurrenceDtoToJson(
  _HealthEventOccurrenceDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'healthEventId': instance.healthEventId,
  'scheduledDate': instance.scheduledDate.toIso8601String(),
  'status': instance.status,
  'completedAt': instance.completedAt?.toIso8601String(),
  'healthEvent': instance.healthEvent,
};
