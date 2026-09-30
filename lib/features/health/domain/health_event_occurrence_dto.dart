import 'package:freezed_annotation/freezed_annotation.dart';
import 'health_event_dto.dart';

part 'health_event_occurrence_dto.freezed.dart';
part 'health_event_occurrence_dto.g.dart';

@freezed
abstract class HealthEventOccurrenceDto with _$HealthEventOccurrenceDto {
  const factory HealthEventOccurrenceDto({
    required String id,
    required String healthEventId,
    required DateTime scheduledDate,
    required String status,
    DateTime? completedAt,
    HealthEventDto? healthEvent,
  }) = _HealthEventOccurrenceDto;

  factory HealthEventOccurrenceDto.fromJson(Map<String, dynamic> json) => _$HealthEventOccurrenceDtoFromJson(json);
}