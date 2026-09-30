// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_event_occurrence_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HealthEventOccurrenceDto {

 String get id; String get healthEventId; DateTime get scheduledDate; String get status; DateTime? get completedAt; HealthEventDto? get healthEvent;
/// Create a copy of HealthEventOccurrenceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HealthEventOccurrenceDtoCopyWith<HealthEventOccurrenceDto> get copyWith => _$HealthEventOccurrenceDtoCopyWithImpl<HealthEventOccurrenceDto>(this as HealthEventOccurrenceDto, _$identity);

  /// Serializes this HealthEventOccurrenceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HealthEventOccurrenceDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HealthEventOccurrenceDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.healthEventId, _this.healthEventId) || other.healthEventId == _this.healthEventId)&&(identical(other.scheduledDate, _this.scheduledDate) || other.scheduledDate == _this.scheduledDate)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt)&&(identical(other.healthEvent, _this.healthEvent) || other.healthEvent == _this.healthEvent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HealthEventOccurrenceDto;
  return Object.hash(runtimeType,_this.id,_this.healthEventId,_this.scheduledDate,_this.status,_this.completedAt,_this.healthEvent);
}

@override
String toString() {
  final _this = this as HealthEventOccurrenceDto;
  return 'HealthEventOccurrenceDto(id: ${_this.id}, healthEventId: ${_this.healthEventId}, scheduledDate: ${_this.scheduledDate}, status: ${_this.status}, completedAt: ${_this.completedAt}, healthEvent: ${_this.healthEvent})';
}


}

/// @nodoc
abstract mixin class $HealthEventOccurrenceDtoCopyWith<$Res>  {
  factory $HealthEventOccurrenceDtoCopyWith(HealthEventOccurrenceDto value, $Res Function(HealthEventOccurrenceDto) _then) = _$HealthEventOccurrenceDtoCopyWithImpl;
@useResult
$Res call({
 String id, String healthEventId, DateTime scheduledDate, String status, DateTime? completedAt, HealthEventDto? healthEvent
});


$HealthEventDtoCopyWith<$Res>? get healthEvent;

}
/// @nodoc
class _$HealthEventOccurrenceDtoCopyWithImpl<$Res>
    implements $HealthEventOccurrenceDtoCopyWith<$Res> {
  _$HealthEventOccurrenceDtoCopyWithImpl(this._self, this._then);

  final HealthEventOccurrenceDto _self;
  final $Res Function(HealthEventOccurrenceDto) _then;

/// Create a copy of HealthEventOccurrenceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? healthEventId = null,Object? scheduledDate = null,Object? status = null,Object? completedAt = freezed,Object? healthEvent = freezed,}) {
  return _then(HealthEventOccurrenceDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,healthEventId: null == healthEventId ? _self.healthEventId : healthEventId // ignore: cast_nullable_to_non_nullable
as String,scheduledDate: null == scheduledDate ? _self.scheduledDate : scheduledDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,healthEvent: freezed == healthEvent ? _self.healthEvent : healthEvent // ignore: cast_nullable_to_non_nullable
as HealthEventDto?,
  ));
}
/// Create a copy of HealthEventOccurrenceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HealthEventDtoCopyWith<$Res>? get healthEvent {
    if (_self.healthEvent == null) {
    return null;
  }

  return $HealthEventDtoCopyWith<$Res>(_self.healthEvent!, (value) {
    return _then(_self.copyWith(healthEvent: value));
  });
}
}


/// Adds pattern-matching-related methods to [HealthEventOccurrenceDto].
extension HealthEventOccurrenceDtoPatterns on HealthEventOccurrenceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HealthEventOccurrenceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HealthEventOccurrenceDto() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HealthEventOccurrenceDto value)  $default,){
final _that = this;
switch (_that) {
case _HealthEventOccurrenceDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HealthEventOccurrenceDto value)?  $default,){
final _that = this;
switch (_that) {
case _HealthEventOccurrenceDto() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String healthEventId,  DateTime scheduledDate,  String status,  DateTime? completedAt,  HealthEventDto? healthEvent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HealthEventOccurrenceDto() when $default != null:
return $default(_that.id,_that.healthEventId,_that.scheduledDate,_that.status,_that.completedAt,_that.healthEvent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String healthEventId,  DateTime scheduledDate,  String status,  DateTime? completedAt,  HealthEventDto? healthEvent)  $default,) {final _that = this;
switch (_that) {
case _HealthEventOccurrenceDto():
return $default(_that.id,_that.healthEventId,_that.scheduledDate,_that.status,_that.completedAt,_that.healthEvent);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String healthEventId,  DateTime scheduledDate,  String status,  DateTime? completedAt,  HealthEventDto? healthEvent)?  $default,) {final _that = this;
switch (_that) {
case _HealthEventOccurrenceDto() when $default != null:
return $default(_that.id,_that.healthEventId,_that.scheduledDate,_that.status,_that.completedAt,_that.healthEvent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HealthEventOccurrenceDto implements HealthEventOccurrenceDto {
  const _HealthEventOccurrenceDto({required this.id, required this.healthEventId, required this.scheduledDate, required this.status, this.completedAt, this.healthEvent});
  factory _HealthEventOccurrenceDto.fromJson(Map<String, dynamic> json) => _$HealthEventOccurrenceDtoFromJson(json);

@override final  String id;
@override final  String healthEventId;
@override final  DateTime scheduledDate;
@override final  String status;
@override final  DateTime? completedAt;
@override final  HealthEventDto? healthEvent;

/// Create a copy of HealthEventOccurrenceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HealthEventOccurrenceDtoCopyWith<_HealthEventOccurrenceDto> get copyWith => __$HealthEventOccurrenceDtoCopyWithImpl<_HealthEventOccurrenceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HealthEventOccurrenceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HealthEventOccurrenceDto&&(identical(other.id, id) || other.id == id)&&(identical(other.healthEventId, healthEventId) || other.healthEventId == healthEventId)&&(identical(other.scheduledDate, scheduledDate) || other.scheduledDate == scheduledDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.healthEvent, healthEvent) || other.healthEvent == healthEvent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,healthEventId,scheduledDate,status,completedAt,healthEvent);
}

@override
String toString() {
    return 'HealthEventOccurrenceDto(id: $id, healthEventId: $healthEventId, scheduledDate: $scheduledDate, status: $status, completedAt: $completedAt, healthEvent: $healthEvent)';
}


}

/// @nodoc
abstract mixin class _$HealthEventOccurrenceDtoCopyWith<$Res> implements $HealthEventOccurrenceDtoCopyWith<$Res> {
  factory _$HealthEventOccurrenceDtoCopyWith(_HealthEventOccurrenceDto value, $Res Function(_HealthEventOccurrenceDto) _then) = __$HealthEventOccurrenceDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String healthEventId, DateTime scheduledDate, String status, DateTime? completedAt, HealthEventDto? healthEvent
});


@override $HealthEventDtoCopyWith<$Res>? get healthEvent;

}
/// @nodoc
class __$HealthEventOccurrenceDtoCopyWithImpl<$Res>
    implements _$HealthEventOccurrenceDtoCopyWith<$Res> {
  __$HealthEventOccurrenceDtoCopyWithImpl(this._self, this._then);

  final _HealthEventOccurrenceDto _self;
  final $Res Function(_HealthEventOccurrenceDto) _then;

/// Create a copy of HealthEventOccurrenceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? healthEventId = null,Object? scheduledDate = null,Object? status = null,Object? completedAt = freezed,Object? healthEvent = freezed,}) {
  return _then(_HealthEventOccurrenceDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,healthEventId: null == healthEventId ? _self.healthEventId : healthEventId // ignore: cast_nullable_to_non_nullable
as String,scheduledDate: null == scheduledDate ? _self.scheduledDate : scheduledDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,healthEvent: freezed == healthEvent ? _self.healthEvent : healthEvent // ignore: cast_nullable_to_non_nullable
as HealthEventDto?,
  ));
}

/// Create a copy of HealthEventOccurrenceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HealthEventDtoCopyWith<$Res>? get healthEvent {
    if (_self.healthEvent == null) {
    return null;
  }

  return $HealthEventDtoCopyWith<$Res>(_self.healthEvent!, (value) {
    return _then(_self.copyWith(healthEvent: value));
  });
}
}

// dart format on
