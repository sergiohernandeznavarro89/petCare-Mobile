// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VetVisitEventDto _$VetVisitEventDtoFromJson(
  Map<String, dynamic> json,
) => VetVisitEventDto(
  id: json['id'] as String,
  petId: json['petId'] as String,
  eventType: EventTypeDefinitionDto.fromJson(
    json['eventType'] as Map<String, dynamic>,
  ),
  date: DateTime.parse(json['date'] as String),
  title: json['title'] as String,
  notes: json['notes'] as String?,
  weight: (json['weight'] as num?)?.toDouble(),
  veterinarianName: json['veterinarianName'] as String?,
  clinicName: json['clinicName'] as String?,
  diagnosis: json['diagnosis'] as String?,
  isHospitalization: json['isHospitalization'] as bool? ?? false,
  dischargeDate: json['dischargeDate'] == null
      ? null
      : DateTime.parse(json['dischargeDate'] as String),
  parentId: json['parentId'] as String?,
  hasCompletedOccurrences: json['hasCompletedOccurrences'] as bool? ?? false,
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  occurrences: (json['occurrences'] as List<dynamic>?)
      ?.map((e) => HealthEventOccurrenceDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  $type: json['healthEventType'] as String?,
);

Map<String, dynamic> _$VetVisitEventDtoToJson(VetVisitEventDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'petId': instance.petId,
      'eventType': instance.eventType,
      'date': instance.date.toIso8601String(),
      'title': instance.title,
      'notes': instance.notes,
      'weight': instance.weight,
      'veterinarianName': instance.veterinarianName,
      'clinicName': instance.clinicName,
      'diagnosis': instance.diagnosis,
      'isHospitalization': instance.isHospitalization,
      'dischargeDate': instance.dischargeDate?.toIso8601String(),
      'parentId': instance.parentId,
      'hasCompletedOccurrences': instance.hasCompletedOccurrences,
      'endDate': instance.endDate?.toIso8601String(),
      'occurrences': instance.occurrences,
      'healthEventType': instance.$type,
    };

MedicationEventDto _$MedicationEventDtoFromJson(
  Map<String, dynamic> json,
) => MedicationEventDto(
  id: json['id'] as String,
  petId: json['petId'] as String,
  eventType: EventTypeDefinitionDto.fromJson(
    json['eventType'] as Map<String, dynamic>,
  ),
  date: DateTime.parse(json['date'] as String),
  title: json['title'] as String,
  notes: json['notes'] as String?,
  weight: (json['weight'] as num?)?.toDouble(),
  drugName: json['drugName'] as String,
  dosage: json['dosage'] as String,
  frequencyValue: (json['frequencyValue'] as num).toInt(),
  frequencyUnit: (json['frequencyUnit'] as num).toInt(),
  startDate: DateTime.parse(json['startDate'] as String),
  parentId: json['parentId'] as String?,
  hasCompletedOccurrences: json['hasCompletedOccurrences'] as bool? ?? false,
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  occurrences: (json['occurrences'] as List<dynamic>?)
      ?.map((e) => HealthEventOccurrenceDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  $type: json['healthEventType'] as String?,
);

Map<String, dynamic> _$MedicationEventDtoToJson(MedicationEventDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'petId': instance.petId,
      'eventType': instance.eventType,
      'date': instance.date.toIso8601String(),
      'title': instance.title,
      'notes': instance.notes,
      'weight': instance.weight,
      'drugName': instance.drugName,
      'dosage': instance.dosage,
      'frequencyValue': instance.frequencyValue,
      'frequencyUnit': instance.frequencyUnit,
      'startDate': instance.startDate.toIso8601String(),
      'parentId': instance.parentId,
      'hasCompletedOccurrences': instance.hasCompletedOccurrences,
      'endDate': instance.endDate?.toIso8601String(),
      'occurrences': instance.occurrences,
      'healthEventType': instance.$type,
    };

VaccineEventDto _$VaccineEventDtoFromJson(
  Map<String, dynamic> json,
) => VaccineEventDto(
  id: json['id'] as String,
  petId: json['petId'] as String,
  eventType: EventTypeDefinitionDto.fromJson(
    json['eventType'] as Map<String, dynamic>,
  ),
  date: DateTime.parse(json['date'] as String),
  title: json['title'] as String,
  notes: json['notes'] as String?,
  weight: (json['weight'] as num?)?.toDouble(),
  vaccineName: json['vaccineName'] as String,
  frequencyValue: (json['frequencyValue'] as num).toInt(),
  frequencyUnit: (json['frequencyUnit'] as num).toInt(),
  parentId: json['parentId'] as String?,
  hasCompletedOccurrences: json['hasCompletedOccurrences'] as bool? ?? false,
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  occurrences: (json['occurrences'] as List<dynamic>?)
      ?.map((e) => HealthEventOccurrenceDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  $type: json['healthEventType'] as String?,
);

Map<String, dynamic> _$VaccineEventDtoToJson(VaccineEventDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'petId': instance.petId,
      'eventType': instance.eventType,
      'date': instance.date.toIso8601String(),
      'title': instance.title,
      'notes': instance.notes,
      'weight': instance.weight,
      'vaccineName': instance.vaccineName,
      'frequencyValue': instance.frequencyValue,
      'frequencyUnit': instance.frequencyUnit,
      'parentId': instance.parentId,
      'hasCompletedOccurrences': instance.hasCompletedOccurrences,
      'endDate': instance.endDate?.toIso8601String(),
      'occurrences': instance.occurrences,
      'healthEventType': instance.$type,
    };

CustomHealthEventDto _$CustomHealthEventDtoFromJson(
  Map<String, dynamic> json,
) => CustomHealthEventDto(
  id: json['id'] as String,
  petId: json['petId'] as String,
  eventType: EventTypeDefinitionDto.fromJson(
    json['eventType'] as Map<String, dynamic>,
  ),
  date: DateTime.parse(json['date'] as String),
  title: json['title'] as String,
  notes: json['notes'] as String?,
  weight: (json['weight'] as num?)?.toDouble(),
  frequencyValue: (json['frequencyValue'] as num).toInt(),
  frequencyUnit: (json['frequencyUnit'] as num).toInt(),
  parentId: json['parentId'] as String?,
  hasCompletedOccurrences: json['hasCompletedOccurrences'] as bool? ?? false,
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  occurrences: (json['occurrences'] as List<dynamic>?)
      ?.map((e) => HealthEventOccurrenceDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  $type: json['healthEventType'] as String?,
);

Map<String, dynamic> _$CustomHealthEventDtoToJson(
  CustomHealthEventDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'petId': instance.petId,
  'eventType': instance.eventType,
  'date': instance.date.toIso8601String(),
  'title': instance.title,
  'notes': instance.notes,
  'weight': instance.weight,
  'frequencyValue': instance.frequencyValue,
  'frequencyUnit': instance.frequencyUnit,
  'parentId': instance.parentId,
  'hasCompletedOccurrences': instance.hasCompletedOccurrences,
  'endDate': instance.endDate?.toIso8601String(),
  'occurrences': instance.occurrences,
  'healthEventType': instance.$type,
};
