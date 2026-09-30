// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_event_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
HealthEventDto _$HealthEventDtoFromJson(
  Map<String, dynamic> json
) {
        switch (json['healthEventType']) {
                  case 'VetVisit':
          return VetVisitEventDto.fromJson(
            json
          );
                case 'Medication':
          return MedicationEventDto.fromJson(
            json
          );
                case 'Vaccine':
          return VaccineEventDto.fromJson(
            json
          );
                case 'Custom':
          return CustomHealthEventDto.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'healthEventType',
  'HealthEventDto',
  'Invalid union type "${json['healthEventType']}"!'
);
        }
      
}

/// @nodoc
mixin _$HealthEventDto {

 String get id; String get petId; EventTypeDefinitionDto get eventType; DateTime get date; String get title; String? get notes; double? get weight; String? get parentId;
/// Create a copy of HealthEventDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HealthEventDtoCopyWith<HealthEventDto> get copyWith => _$HealthEventDtoCopyWithImpl<HealthEventDto>(this as HealthEventDto, _$identity);

  /// Serializes this HealthEventDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HealthEventDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HealthEventDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.petId, _this.petId) || other.petId == _this.petId)&&(identical(other.eventType, _this.eventType) || other.eventType == _this.eventType)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.weight, _this.weight) || other.weight == _this.weight)&&(identical(other.parentId, _this.parentId) || other.parentId == _this.parentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HealthEventDto;
  return Object.hash(runtimeType,_this.id,_this.petId,_this.eventType,_this.date,_this.title,_this.notes,_this.weight,_this.parentId);
}

@override
String toString() {
  final _this = this as HealthEventDto;
  return 'HealthEventDto(id: ${_this.id}, petId: ${_this.petId}, eventType: ${_this.eventType}, date: ${_this.date}, title: ${_this.title}, notes: ${_this.notes}, weight: ${_this.weight}, parentId: ${_this.parentId})';
}


}

/// @nodoc
abstract mixin class $HealthEventDtoCopyWith<$Res>  {
  factory $HealthEventDtoCopyWith(HealthEventDto value, $Res Function(HealthEventDto) _then) = _$HealthEventDtoCopyWithImpl;
@useResult
$Res call({
 String id, String petId, EventTypeDefinitionDto eventType, DateTime date, String title, String? notes, double? weight, String? parentId
});


$EventTypeDefinitionDtoCopyWith<$Res> get eventType;

}
/// @nodoc
class _$HealthEventDtoCopyWithImpl<$Res>
    implements $HealthEventDtoCopyWith<$Res> {
  _$HealthEventDtoCopyWithImpl(this._self, this._then);

  final HealthEventDto _self;
  final $Res Function(HealthEventDto) _then;

/// Create a copy of HealthEventDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? petId = null,Object? eventType = null,Object? date = null,Object? title = null,Object? notes = freezed,Object? weight = freezed,Object? parentId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as EventTypeDefinitionDto,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of HealthEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTypeDefinitionDtoCopyWith<$Res> get eventType {
  
  return $EventTypeDefinitionDtoCopyWith<$Res>(_self.eventType, (value) {
    return _then(_self.copyWith(eventType: value));
  });
}
}


/// Adds pattern-matching-related methods to [HealthEventDto].
extension HealthEventDtoPatterns on HealthEventDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VetVisitEventDto value)?  vetVisit,TResult Function( MedicationEventDto value)?  medication,TResult Function( VaccineEventDto value)?  vaccine,TResult Function( CustomHealthEventDto value)?  custom,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VetVisitEventDto() when vetVisit != null:
return vetVisit(_that);case MedicationEventDto() when medication != null:
return medication(_that);case VaccineEventDto() when vaccine != null:
return vaccine(_that);case CustomHealthEventDto() when custom != null:
return custom(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VetVisitEventDto value)  vetVisit,required TResult Function( MedicationEventDto value)  medication,required TResult Function( VaccineEventDto value)  vaccine,required TResult Function( CustomHealthEventDto value)  custom,}){
final _that = this;
switch (_that) {
case VetVisitEventDto():
return vetVisit(_that);case MedicationEventDto():
return medication(_that);case VaccineEventDto():
return vaccine(_that);case CustomHealthEventDto():
return custom(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VetVisitEventDto value)?  vetVisit,TResult? Function( MedicationEventDto value)?  medication,TResult? Function( VaccineEventDto value)?  vaccine,TResult? Function( CustomHealthEventDto value)?  custom,}){
final _that = this;
switch (_that) {
case VetVisitEventDto() when vetVisit != null:
return vetVisit(_that);case MedicationEventDto() when medication != null:
return medication(_that);case VaccineEventDto() when vaccine != null:
return vaccine(_that);case CustomHealthEventDto() when custom != null:
return custom(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  String petId,  EventTypeDefinitionDto eventType,  DateTime date,  String title,  String? notes,  double? weight,  String? veterinarianName,  String? clinicName,  String? diagnosis,  bool isHospitalization,  DateTime? dischargeDate,  String? parentId)?  vetVisit,TResult Function( String id,  String petId,  EventTypeDefinitionDto eventType,  DateTime date,  String title,  String? notes,  double? weight,  String drugName,  String dosage,  int frequencyValue,  int frequencyUnit,  DateTime startDate,  DateTime? endDate,  String? parentId)?  medication,TResult Function( String id,  String petId,  EventTypeDefinitionDto eventType,  DateTime date,  String title,  String? notes,  double? weight,  String vaccineName,  int frequencyValue,  int frequencyUnit,  String? parentId)?  vaccine,TResult Function( String id,  String petId,  EventTypeDefinitionDto eventType,  DateTime date,  String title,  String? notes,  double? weight,  int frequencyValue,  int frequencyUnit,  String? parentId)?  custom,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VetVisitEventDto() when vetVisit != null:
return vetVisit(_that.id,_that.petId,_that.eventType,_that.date,_that.title,_that.notes,_that.weight,_that.veterinarianName,_that.clinicName,_that.diagnosis,_that.isHospitalization,_that.dischargeDate,_that.parentId);case MedicationEventDto() when medication != null:
return medication(_that.id,_that.petId,_that.eventType,_that.date,_that.title,_that.notes,_that.weight,_that.drugName,_that.dosage,_that.frequencyValue,_that.frequencyUnit,_that.startDate,_that.endDate,_that.parentId);case VaccineEventDto() when vaccine != null:
return vaccine(_that.id,_that.petId,_that.eventType,_that.date,_that.title,_that.notes,_that.weight,_that.vaccineName,_that.frequencyValue,_that.frequencyUnit,_that.parentId);case CustomHealthEventDto() when custom != null:
return custom(_that.id,_that.petId,_that.eventType,_that.date,_that.title,_that.notes,_that.weight,_that.frequencyValue,_that.frequencyUnit,_that.parentId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  String petId,  EventTypeDefinitionDto eventType,  DateTime date,  String title,  String? notes,  double? weight,  String? veterinarianName,  String? clinicName,  String? diagnosis,  bool isHospitalization,  DateTime? dischargeDate,  String? parentId)  vetVisit,required TResult Function( String id,  String petId,  EventTypeDefinitionDto eventType,  DateTime date,  String title,  String? notes,  double? weight,  String drugName,  String dosage,  int frequencyValue,  int frequencyUnit,  DateTime startDate,  DateTime? endDate,  String? parentId)  medication,required TResult Function( String id,  String petId,  EventTypeDefinitionDto eventType,  DateTime date,  String title,  String? notes,  double? weight,  String vaccineName,  int frequencyValue,  int frequencyUnit,  String? parentId)  vaccine,required TResult Function( String id,  String petId,  EventTypeDefinitionDto eventType,  DateTime date,  String title,  String? notes,  double? weight,  int frequencyValue,  int frequencyUnit,  String? parentId)  custom,}) {final _that = this;
switch (_that) {
case VetVisitEventDto():
return vetVisit(_that.id,_that.petId,_that.eventType,_that.date,_that.title,_that.notes,_that.weight,_that.veterinarianName,_that.clinicName,_that.diagnosis,_that.isHospitalization,_that.dischargeDate,_that.parentId);case MedicationEventDto():
return medication(_that.id,_that.petId,_that.eventType,_that.date,_that.title,_that.notes,_that.weight,_that.drugName,_that.dosage,_that.frequencyValue,_that.frequencyUnit,_that.startDate,_that.endDate,_that.parentId);case VaccineEventDto():
return vaccine(_that.id,_that.petId,_that.eventType,_that.date,_that.title,_that.notes,_that.weight,_that.vaccineName,_that.frequencyValue,_that.frequencyUnit,_that.parentId);case CustomHealthEventDto():
return custom(_that.id,_that.petId,_that.eventType,_that.date,_that.title,_that.notes,_that.weight,_that.frequencyValue,_that.frequencyUnit,_that.parentId);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  String petId,  EventTypeDefinitionDto eventType,  DateTime date,  String title,  String? notes,  double? weight,  String? veterinarianName,  String? clinicName,  String? diagnosis,  bool isHospitalization,  DateTime? dischargeDate,  String? parentId)?  vetVisit,TResult? Function( String id,  String petId,  EventTypeDefinitionDto eventType,  DateTime date,  String title,  String? notes,  double? weight,  String drugName,  String dosage,  int frequencyValue,  int frequencyUnit,  DateTime startDate,  DateTime? endDate,  String? parentId)?  medication,TResult? Function( String id,  String petId,  EventTypeDefinitionDto eventType,  DateTime date,  String title,  String? notes,  double? weight,  String vaccineName,  int frequencyValue,  int frequencyUnit,  String? parentId)?  vaccine,TResult? Function( String id,  String petId,  EventTypeDefinitionDto eventType,  DateTime date,  String title,  String? notes,  double? weight,  int frequencyValue,  int frequencyUnit,  String? parentId)?  custom,}) {final _that = this;
switch (_that) {
case VetVisitEventDto() when vetVisit != null:
return vetVisit(_that.id,_that.petId,_that.eventType,_that.date,_that.title,_that.notes,_that.weight,_that.veterinarianName,_that.clinicName,_that.diagnosis,_that.isHospitalization,_that.dischargeDate,_that.parentId);case MedicationEventDto() when medication != null:
return medication(_that.id,_that.petId,_that.eventType,_that.date,_that.title,_that.notes,_that.weight,_that.drugName,_that.dosage,_that.frequencyValue,_that.frequencyUnit,_that.startDate,_that.endDate,_that.parentId);case VaccineEventDto() when vaccine != null:
return vaccine(_that.id,_that.petId,_that.eventType,_that.date,_that.title,_that.notes,_that.weight,_that.vaccineName,_that.frequencyValue,_that.frequencyUnit,_that.parentId);case CustomHealthEventDto() when custom != null:
return custom(_that.id,_that.petId,_that.eventType,_that.date,_that.title,_that.notes,_that.weight,_that.frequencyValue,_that.frequencyUnit,_that.parentId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class VetVisitEventDto implements HealthEventDto {
  const VetVisitEventDto({required this.id, required this.petId, required this.eventType, required this.date, required this.title, this.notes, this.weight, this.veterinarianName, this.clinicName, this.diagnosis, this.isHospitalization = false, this.dischargeDate, this.parentId,  String? $type}): $type = $type ?? 'VetVisit';
  factory VetVisitEventDto.fromJson(Map<String, dynamic> json) => _$VetVisitEventDtoFromJson(json);

@override final  String id;
@override final  String petId;
@override final  EventTypeDefinitionDto eventType;
@override final  DateTime date;
@override final  String title;
@override final  String? notes;
@override final  double? weight;
 final  String? veterinarianName;
 final  String? clinicName;
 final  String? diagnosis;
@JsonKey() final  bool isHospitalization;
 final  DateTime? dischargeDate;
@override final  String? parentId;

@JsonKey(name: 'healthEventType')
final String $type;


/// Create a copy of HealthEventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VetVisitEventDtoCopyWith<VetVisitEventDto> get copyWith => _$VetVisitEventDtoCopyWithImpl<VetVisitEventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VetVisitEventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is VetVisitEventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.veterinarianName, veterinarianName) || other.veterinarianName == veterinarianName)&&(identical(other.clinicName, clinicName) || other.clinicName == clinicName)&&(identical(other.diagnosis, diagnosis) || other.diagnosis == diagnosis)&&(identical(other.isHospitalization, isHospitalization) || other.isHospitalization == isHospitalization)&&(identical(other.dischargeDate, dischargeDate) || other.dischargeDate == dischargeDate)&&(identical(other.parentId, parentId) || other.parentId == parentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,petId,eventType,date,title,notes,weight,veterinarianName,clinicName,diagnosis,isHospitalization,dischargeDate,parentId);
}

@override
String toString() {
    return 'HealthEventDto.vetVisit(id: $id, petId: $petId, eventType: $eventType, date: $date, title: $title, notes: $notes, weight: $weight, veterinarianName: $veterinarianName, clinicName: $clinicName, diagnosis: $diagnosis, isHospitalization: $isHospitalization, dischargeDate: $dischargeDate, parentId: $parentId)';
}


}

/// @nodoc
abstract mixin class $VetVisitEventDtoCopyWith<$Res> implements $HealthEventDtoCopyWith<$Res> {
  factory $VetVisitEventDtoCopyWith(VetVisitEventDto value, $Res Function(VetVisitEventDto) _then) = _$VetVisitEventDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String petId, EventTypeDefinitionDto eventType, DateTime date, String title, String? notes, double? weight, String? veterinarianName, String? clinicName, String? diagnosis, bool isHospitalization, DateTime? dischargeDate, String? parentId
});


@override $EventTypeDefinitionDtoCopyWith<$Res> get eventType;

}
/// @nodoc
class _$VetVisitEventDtoCopyWithImpl<$Res>
    implements $VetVisitEventDtoCopyWith<$Res> {
  _$VetVisitEventDtoCopyWithImpl(this._self, this._then);

  final VetVisitEventDto _self;
  final $Res Function(VetVisitEventDto) _then;

/// Create a copy of HealthEventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? petId = null,Object? eventType = null,Object? date = null,Object? title = null,Object? notes = freezed,Object? weight = freezed,Object? veterinarianName = freezed,Object? clinicName = freezed,Object? diagnosis = freezed,Object? isHospitalization = null,Object? dischargeDate = freezed,Object? parentId = freezed,}) {
  return _then(VetVisitEventDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as EventTypeDefinitionDto,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,veterinarianName: freezed == veterinarianName ? _self.veterinarianName : veterinarianName // ignore: cast_nullable_to_non_nullable
as String?,clinicName: freezed == clinicName ? _self.clinicName : clinicName // ignore: cast_nullable_to_non_nullable
as String?,diagnosis: freezed == diagnosis ? _self.diagnosis : diagnosis // ignore: cast_nullable_to_non_nullable
as String?,isHospitalization: null == isHospitalization ? _self.isHospitalization : isHospitalization // ignore: cast_nullable_to_non_nullable
as bool,dischargeDate: freezed == dischargeDate ? _self.dischargeDate : dischargeDate // ignore: cast_nullable_to_non_nullable
as DateTime?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of HealthEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTypeDefinitionDtoCopyWith<$Res> get eventType {
  
  return $EventTypeDefinitionDtoCopyWith<$Res>(_self.eventType, (value) {
    return _then(_self.copyWith(eventType: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class MedicationEventDto implements HealthEventDto {
  const MedicationEventDto({required this.id, required this.petId, required this.eventType, required this.date, required this.title, this.notes, this.weight, required this.drugName, required this.dosage, required this.frequencyValue, required this.frequencyUnit, required this.startDate, this.endDate, this.parentId,  String? $type}): $type = $type ?? 'Medication';
  factory MedicationEventDto.fromJson(Map<String, dynamic> json) => _$MedicationEventDtoFromJson(json);

@override final  String id;
@override final  String petId;
@override final  EventTypeDefinitionDto eventType;
@override final  DateTime date;
@override final  String title;
@override final  String? notes;
@override final  double? weight;
 final  String drugName;
 final  String dosage;
 final  int frequencyValue;
 final  int frequencyUnit;
 final  DateTime startDate;
 final  DateTime? endDate;
@override final  String? parentId;

@JsonKey(name: 'healthEventType')
final String $type;


/// Create a copy of HealthEventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicationEventDtoCopyWith<MedicationEventDto> get copyWith => _$MedicationEventDtoCopyWithImpl<MedicationEventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MedicationEventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicationEventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.drugName, drugName) || other.drugName == drugName)&&(identical(other.dosage, dosage) || other.dosage == dosage)&&(identical(other.frequencyValue, frequencyValue) || other.frequencyValue == frequencyValue)&&(identical(other.frequencyUnit, frequencyUnit) || other.frequencyUnit == frequencyUnit)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.parentId, parentId) || other.parentId == parentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,petId,eventType,date,title,notes,weight,drugName,dosage,frequencyValue,frequencyUnit,startDate,endDate,parentId);
}

@override
String toString() {
    return 'HealthEventDto.medication(id: $id, petId: $petId, eventType: $eventType, date: $date, title: $title, notes: $notes, weight: $weight, drugName: $drugName, dosage: $dosage, frequencyValue: $frequencyValue, frequencyUnit: $frequencyUnit, startDate: $startDate, endDate: $endDate, parentId: $parentId)';
}


}

/// @nodoc
abstract mixin class $MedicationEventDtoCopyWith<$Res> implements $HealthEventDtoCopyWith<$Res> {
  factory $MedicationEventDtoCopyWith(MedicationEventDto value, $Res Function(MedicationEventDto) _then) = _$MedicationEventDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String petId, EventTypeDefinitionDto eventType, DateTime date, String title, String? notes, double? weight, String drugName, String dosage, int frequencyValue, int frequencyUnit, DateTime startDate, DateTime? endDate, String? parentId
});


@override $EventTypeDefinitionDtoCopyWith<$Res> get eventType;

}
/// @nodoc
class _$MedicationEventDtoCopyWithImpl<$Res>
    implements $MedicationEventDtoCopyWith<$Res> {
  _$MedicationEventDtoCopyWithImpl(this._self, this._then);

  final MedicationEventDto _self;
  final $Res Function(MedicationEventDto) _then;

/// Create a copy of HealthEventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? petId = null,Object? eventType = null,Object? date = null,Object? title = null,Object? notes = freezed,Object? weight = freezed,Object? drugName = null,Object? dosage = null,Object? frequencyValue = null,Object? frequencyUnit = null,Object? startDate = null,Object? endDate = freezed,Object? parentId = freezed,}) {
  return _then(MedicationEventDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as EventTypeDefinitionDto,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,drugName: null == drugName ? _self.drugName : drugName // ignore: cast_nullable_to_non_nullable
as String,dosage: null == dosage ? _self.dosage : dosage // ignore: cast_nullable_to_non_nullable
as String,frequencyValue: null == frequencyValue ? _self.frequencyValue : frequencyValue // ignore: cast_nullable_to_non_nullable
as int,frequencyUnit: null == frequencyUnit ? _self.frequencyUnit : frequencyUnit // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of HealthEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTypeDefinitionDtoCopyWith<$Res> get eventType {
  
  return $EventTypeDefinitionDtoCopyWith<$Res>(_self.eventType, (value) {
    return _then(_self.copyWith(eventType: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class VaccineEventDto implements HealthEventDto {
  const VaccineEventDto({required this.id, required this.petId, required this.eventType, required this.date, required this.title, this.notes, this.weight, required this.vaccineName, required this.frequencyValue, required this.frequencyUnit, this.parentId,  String? $type}): $type = $type ?? 'Vaccine';
  factory VaccineEventDto.fromJson(Map<String, dynamic> json) => _$VaccineEventDtoFromJson(json);

@override final  String id;
@override final  String petId;
@override final  EventTypeDefinitionDto eventType;
@override final  DateTime date;
@override final  String title;
@override final  String? notes;
@override final  double? weight;
 final  String vaccineName;
 final  int frequencyValue;
 final  int frequencyUnit;
@override final  String? parentId;

@JsonKey(name: 'healthEventType')
final String $type;


/// Create a copy of HealthEventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VaccineEventDtoCopyWith<VaccineEventDto> get copyWith => _$VaccineEventDtoCopyWithImpl<VaccineEventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VaccineEventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is VaccineEventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.vaccineName, vaccineName) || other.vaccineName == vaccineName)&&(identical(other.frequencyValue, frequencyValue) || other.frequencyValue == frequencyValue)&&(identical(other.frequencyUnit, frequencyUnit) || other.frequencyUnit == frequencyUnit)&&(identical(other.parentId, parentId) || other.parentId == parentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,petId,eventType,date,title,notes,weight,vaccineName,frequencyValue,frequencyUnit,parentId);
}

@override
String toString() {
    return 'HealthEventDto.vaccine(id: $id, petId: $petId, eventType: $eventType, date: $date, title: $title, notes: $notes, weight: $weight, vaccineName: $vaccineName, frequencyValue: $frequencyValue, frequencyUnit: $frequencyUnit, parentId: $parentId)';
}


}

/// @nodoc
abstract mixin class $VaccineEventDtoCopyWith<$Res> implements $HealthEventDtoCopyWith<$Res> {
  factory $VaccineEventDtoCopyWith(VaccineEventDto value, $Res Function(VaccineEventDto) _then) = _$VaccineEventDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String petId, EventTypeDefinitionDto eventType, DateTime date, String title, String? notes, double? weight, String vaccineName, int frequencyValue, int frequencyUnit, String? parentId
});


@override $EventTypeDefinitionDtoCopyWith<$Res> get eventType;

}
/// @nodoc
class _$VaccineEventDtoCopyWithImpl<$Res>
    implements $VaccineEventDtoCopyWith<$Res> {
  _$VaccineEventDtoCopyWithImpl(this._self, this._then);

  final VaccineEventDto _self;
  final $Res Function(VaccineEventDto) _then;

/// Create a copy of HealthEventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? petId = null,Object? eventType = null,Object? date = null,Object? title = null,Object? notes = freezed,Object? weight = freezed,Object? vaccineName = null,Object? frequencyValue = null,Object? frequencyUnit = null,Object? parentId = freezed,}) {
  return _then(VaccineEventDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as EventTypeDefinitionDto,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,vaccineName: null == vaccineName ? _self.vaccineName : vaccineName // ignore: cast_nullable_to_non_nullable
as String,frequencyValue: null == frequencyValue ? _self.frequencyValue : frequencyValue // ignore: cast_nullable_to_non_nullable
as int,frequencyUnit: null == frequencyUnit ? _self.frequencyUnit : frequencyUnit // ignore: cast_nullable_to_non_nullable
as int,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of HealthEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTypeDefinitionDtoCopyWith<$Res> get eventType {
  
  return $EventTypeDefinitionDtoCopyWith<$Res>(_self.eventType, (value) {
    return _then(_self.copyWith(eventType: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class CustomHealthEventDto implements HealthEventDto {
  const CustomHealthEventDto({required this.id, required this.petId, required this.eventType, required this.date, required this.title, this.notes, this.weight, required this.frequencyValue, required this.frequencyUnit, this.parentId,  String? $type}): $type = $type ?? 'Custom';
  factory CustomHealthEventDto.fromJson(Map<String, dynamic> json) => _$CustomHealthEventDtoFromJson(json);

@override final  String id;
@override final  String petId;
@override final  EventTypeDefinitionDto eventType;
@override final  DateTime date;
@override final  String title;
@override final  String? notes;
@override final  double? weight;
 final  int frequencyValue;
 final  int frequencyUnit;
@override final  String? parentId;

@JsonKey(name: 'healthEventType')
final String $type;


/// Create a copy of HealthEventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomHealthEventDtoCopyWith<CustomHealthEventDto> get copyWith => _$CustomHealthEventDtoCopyWithImpl<CustomHealthEventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomHealthEventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomHealthEventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.frequencyValue, frequencyValue) || other.frequencyValue == frequencyValue)&&(identical(other.frequencyUnit, frequencyUnit) || other.frequencyUnit == frequencyUnit)&&(identical(other.parentId, parentId) || other.parentId == parentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,petId,eventType,date,title,notes,weight,frequencyValue,frequencyUnit,parentId);
}

@override
String toString() {
    return 'HealthEventDto.custom(id: $id, petId: $petId, eventType: $eventType, date: $date, title: $title, notes: $notes, weight: $weight, frequencyValue: $frequencyValue, frequencyUnit: $frequencyUnit, parentId: $parentId)';
}


}

/// @nodoc
abstract mixin class $CustomHealthEventDtoCopyWith<$Res> implements $HealthEventDtoCopyWith<$Res> {
  factory $CustomHealthEventDtoCopyWith(CustomHealthEventDto value, $Res Function(CustomHealthEventDto) _then) = _$CustomHealthEventDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String petId, EventTypeDefinitionDto eventType, DateTime date, String title, String? notes, double? weight, int frequencyValue, int frequencyUnit, String? parentId
});


@override $EventTypeDefinitionDtoCopyWith<$Res> get eventType;

}
/// @nodoc
class _$CustomHealthEventDtoCopyWithImpl<$Res>
    implements $CustomHealthEventDtoCopyWith<$Res> {
  _$CustomHealthEventDtoCopyWithImpl(this._self, this._then);

  final CustomHealthEventDto _self;
  final $Res Function(CustomHealthEventDto) _then;

/// Create a copy of HealthEventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? petId = null,Object? eventType = null,Object? date = null,Object? title = null,Object? notes = freezed,Object? weight = freezed,Object? frequencyValue = null,Object? frequencyUnit = null,Object? parentId = freezed,}) {
  return _then(CustomHealthEventDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as EventTypeDefinitionDto,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,frequencyValue: null == frequencyValue ? _self.frequencyValue : frequencyValue // ignore: cast_nullable_to_non_nullable
as int,frequencyUnit: null == frequencyUnit ? _self.frequencyUnit : frequencyUnit // ignore: cast_nullable_to_non_nullable
as int,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of HealthEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTypeDefinitionDtoCopyWith<$Res> get eventType {
  
  return $EventTypeDefinitionDtoCopyWith<$Res>(_self.eventType, (value) {
    return _then(_self.copyWith(eventType: value));
  });
}
}

// dart format on
