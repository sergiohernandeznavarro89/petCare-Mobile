import 'package:freezed_annotation/freezed_annotation.dart';
import 'event_type_definition_dto.dart';

part 'health_event_dto.freezed.dart';
part 'health_event_dto.g.dart';

@Freezed(unionKey: 'healthEventType', unionValueCase: FreezedUnionCase.pascal)
sealed class HealthEventDto with _$HealthEventDto {
  
  @FreezedUnionValue('VetVisit')
  const factory HealthEventDto.vetVisit({
    required String id,
    required String petId,
    required EventTypeDefinitionDto eventType,
    required DateTime date,
    required String title,
    String? notes,
    double? weight,
    String? veterinarianName,
    String? clinicName,
    String? diagnosis,
    @Default(false) bool isHospitalization,
    DateTime? dischargeDate,
    String? parentId,
  }) = VetVisitEventDto;

  @FreezedUnionValue('Medication')
  const factory HealthEventDto.medication({
    required String id,
    required String petId,
    required EventTypeDefinitionDto eventType,
    required DateTime date,
    required String title,
    String? notes,
    double? weight,
    required String drugName,
    required String dosage,
    required int frequencyValue,
    required int frequencyUnit,
    required DateTime startDate,
    DateTime? endDate,
    String? parentId,
  }) = MedicationEventDto;

  @FreezedUnionValue('Vaccine')
  const factory HealthEventDto.vaccine({
    required String id,
    required String petId,
    required EventTypeDefinitionDto eventType,
    required DateTime date,
    required String title,
    String? notes,
    double? weight,
    required String vaccineName,
    required int frequencyValue,
    required int frequencyUnit,
    String? parentId,
  }) = VaccineEventDto;

  @FreezedUnionValue('Custom')
  const factory HealthEventDto.custom({
    required String id,
    required String petId,
    required EventTypeDefinitionDto eventType,
    required DateTime date,
    required String title,
    String? notes,
    double? weight,
    required int frequencyValue,
    required int frequencyUnit,
    String? parentId,
  }) = CustomHealthEventDto;

  factory HealthEventDto.fromJson(Map<String, dynamic> json) =>
      _$HealthEventDtoFromJson(json);
}
extension HealthEventDtoOccurrences on HealthEventDto {
  int get frequencyValue => map(
    vetVisit: (_) => 0,
    medication: (m) => m.frequencyValue,
    vaccine: (v) => v.frequencyValue,
    custom: (c) => c.frequencyValue,
  );

  int get frequencyUnit => map(
    vetVisit: (_) => 0,
    medication: (m) => m.frequencyUnit,
    vaccine: (v) => v.frequencyUnit,
    custom: (c) => c.frequencyUnit,
  );

  List<HealthEventDto> generateOccurrences(DateTime start, DateTime end) {
    if (frequencyValue == 0) {
      if (date.isBefore(end) && (date.isAfter(start) || date.isAtSameMomentAs(start))) {
        return [this];
      }
      return [];
    }

    final occurrences = <HealthEventDto>[];
    DateTime current = date;

    while (current.isBefore(end)) {
      if (current.isAfter(start) || current.isAtSameMomentAs(start)) {
        occurrences.add(copyWith(date: current));
      }

      final fVal = frequencyValue;
      final fUnit = frequencyUnit;

      if (fUnit == 0) {
        current = current.add(Duration(hours: fVal));
      } else if (fUnit == 1) {
        current = current.add(Duration(days: fVal));
      } else if (fUnit == 2) {
        current = current.add(Duration(days: fVal * 7));
      } else if (fUnit == 3) {
        int nextMonth = current.month + fVal;
        int nextYear = current.year + (nextMonth - 1) ~/ 12;
        nextMonth = (nextMonth - 1) % 12 + 1;
        int daysInNextMonth = DateTime(nextYear, nextMonth + 1, 0).day;
        int nextDay = current.day > daysInNextMonth ? daysInNextMonth : current.day;
        current = DateTime(nextYear, nextMonth, nextDay, current.hour, current.minute);
      } else if (fUnit == 4) {
        current = DateTime(current.year + fVal, current.month, current.day, current.hour, current.minute);
      } else {
        break; // Fallback to avoid infinite loop
      }
    }
    return occurrences;
  }
}