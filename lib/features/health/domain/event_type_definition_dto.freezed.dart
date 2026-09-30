// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_type_definition_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventTypeDefinitionDto {

 String get id; String? get userId; String get name; String? get icon; String? get color;
/// Create a copy of EventTypeDefinitionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventTypeDefinitionDtoCopyWith<EventTypeDefinitionDto> get copyWith => _$EventTypeDefinitionDtoCopyWithImpl<EventTypeDefinitionDto>(this as EventTypeDefinitionDto, _$identity);

  /// Serializes this EventTypeDefinitionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EventTypeDefinitionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventTypeDefinitionDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.color, _this.color) || other.color == _this.color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EventTypeDefinitionDto;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.name,_this.icon,_this.color);
}

@override
String toString() {
  final _this = this as EventTypeDefinitionDto;
  return 'EventTypeDefinitionDto(id: ${_this.id}, userId: ${_this.userId}, name: ${_this.name}, icon: ${_this.icon}, color: ${_this.color})';
}


}

/// @nodoc
abstract mixin class $EventTypeDefinitionDtoCopyWith<$Res>  {
  factory $EventTypeDefinitionDtoCopyWith(EventTypeDefinitionDto value, $Res Function(EventTypeDefinitionDto) _then) = _$EventTypeDefinitionDtoCopyWithImpl;
@useResult
$Res call({
 String id, String? userId, String name, String? icon, String? color
});




}
/// @nodoc
class _$EventTypeDefinitionDtoCopyWithImpl<$Res>
    implements $EventTypeDefinitionDtoCopyWith<$Res> {
  _$EventTypeDefinitionDtoCopyWithImpl(this._self, this._then);

  final EventTypeDefinitionDto _self;
  final $Res Function(EventTypeDefinitionDto) _then;

/// Create a copy of EventTypeDefinitionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = freezed,Object? name = null,Object? icon = freezed,Object? color = freezed,}) {
  return _then(EventTypeDefinitionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventTypeDefinitionDto].
extension EventTypeDefinitionDtoPatterns on EventTypeDefinitionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventTypeDefinitionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventTypeDefinitionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventTypeDefinitionDto value)  $default,){
final _that = this;
switch (_that) {
case _EventTypeDefinitionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventTypeDefinitionDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventTypeDefinitionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? userId,  String name,  String? icon,  String? color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventTypeDefinitionDto() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.icon,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? userId,  String name,  String? icon,  String? color)  $default,) {final _that = this;
switch (_that) {
case _EventTypeDefinitionDto():
return $default(_that.id,_that.userId,_that.name,_that.icon,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? userId,  String name,  String? icon,  String? color)?  $default,) {final _that = this;
switch (_that) {
case _EventTypeDefinitionDto() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.icon,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventTypeDefinitionDto implements EventTypeDefinitionDto {
  const _EventTypeDefinitionDto({required this.id, this.userId, required this.name, this.icon, this.color});
  factory _EventTypeDefinitionDto.fromJson(Map<String, dynamic> json) => _$EventTypeDefinitionDtoFromJson(json);

@override final  String id;
@override final  String? userId;
@override final  String name;
@override final  String? icon;
@override final  String? color;

/// Create a copy of EventTypeDefinitionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventTypeDefinitionDtoCopyWith<_EventTypeDefinitionDto> get copyWith => __$EventTypeDefinitionDtoCopyWithImpl<_EventTypeDefinitionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventTypeDefinitionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventTypeDefinitionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,name,icon,color);
}

@override
String toString() {
    return 'EventTypeDefinitionDto(id: $id, userId: $userId, name: $name, icon: $icon, color: $color)';
}


}

/// @nodoc
abstract mixin class _$EventTypeDefinitionDtoCopyWith<$Res> implements $EventTypeDefinitionDtoCopyWith<$Res> {
  factory _$EventTypeDefinitionDtoCopyWith(_EventTypeDefinitionDto value, $Res Function(_EventTypeDefinitionDto) _then) = __$EventTypeDefinitionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String? userId, String name, String? icon, String? color
});




}
/// @nodoc
class __$EventTypeDefinitionDtoCopyWithImpl<$Res>
    implements _$EventTypeDefinitionDtoCopyWith<$Res> {
  __$EventTypeDefinitionDtoCopyWithImpl(this._self, this._then);

  final _EventTypeDefinitionDto _self;
  final $Res Function(_EventTypeDefinitionDto) _then;

/// Create a copy of EventTypeDefinitionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = freezed,Object? name = null,Object? icon = freezed,Object? color = freezed,}) {
  return _then(_EventTypeDefinitionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
