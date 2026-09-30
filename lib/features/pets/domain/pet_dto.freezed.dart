// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pet_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PetDto {

 String get id; String get name; String get species; String? get breed; DateTime? get dateOfBirth; String? get photoUrl; DateTime get createdAt;
/// Create a copy of PetDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PetDtoCopyWith<PetDto> get copyWith => _$PetDtoCopyWithImpl<PetDto>(this as PetDto, _$identity);

  /// Serializes this PetDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PetDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PetDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.species, _this.species) || other.species == _this.species)&&(identical(other.breed, _this.breed) || other.breed == _this.breed)&&(identical(other.dateOfBirth, _this.dateOfBirth) || other.dateOfBirth == _this.dateOfBirth)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PetDto;
  return Object.hash(runtimeType,_this.id,_this.name,_this.species,_this.breed,_this.dateOfBirth,_this.photoUrl,_this.createdAt);
}

@override
String toString() {
  final _this = this as PetDto;
  return 'PetDto(id: ${_this.id}, name: ${_this.name}, species: ${_this.species}, breed: ${_this.breed}, dateOfBirth: ${_this.dateOfBirth}, photoUrl: ${_this.photoUrl}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $PetDtoCopyWith<$Res>  {
  factory $PetDtoCopyWith(PetDto value, $Res Function(PetDto) _then) = _$PetDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String species, String? breed, DateTime? dateOfBirth, String? photoUrl, DateTime createdAt
});




}
/// @nodoc
class _$PetDtoCopyWithImpl<$Res>
    implements $PetDtoCopyWith<$Res> {
  _$PetDtoCopyWithImpl(this._self, this._then);

  final PetDto _self;
  final $Res Function(PetDto) _then;

/// Create a copy of PetDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? species = null,Object? breed = freezed,Object? dateOfBirth = freezed,Object? photoUrl = freezed,Object? createdAt = null,}) {
  return _then(PetDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,breed: freezed == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PetDto].
extension PetDtoPatterns on PetDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PetDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PetDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PetDto value)  $default,){
final _that = this;
switch (_that) {
case _PetDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PetDto value)?  $default,){
final _that = this;
switch (_that) {
case _PetDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String species,  String? breed,  DateTime? dateOfBirth,  String? photoUrl,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PetDto() when $default != null:
return $default(_that.id,_that.name,_that.species,_that.breed,_that.dateOfBirth,_that.photoUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String species,  String? breed,  DateTime? dateOfBirth,  String? photoUrl,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _PetDto():
return $default(_that.id,_that.name,_that.species,_that.breed,_that.dateOfBirth,_that.photoUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String species,  String? breed,  DateTime? dateOfBirth,  String? photoUrl,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PetDto() when $default != null:
return $default(_that.id,_that.name,_that.species,_that.breed,_that.dateOfBirth,_that.photoUrl,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PetDto implements PetDto {
  const _PetDto({required this.id, required this.name, required this.species, this.breed, this.dateOfBirth, this.photoUrl, required this.createdAt});
  factory _PetDto.fromJson(Map<String, dynamic> json) => _$PetDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String species;
@override final  String? breed;
@override final  DateTime? dateOfBirth;
@override final  String? photoUrl;
@override final  DateTime createdAt;

/// Create a copy of PetDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PetDtoCopyWith<_PetDto> get copyWith => __$PetDtoCopyWithImpl<_PetDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PetDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.species, species) || other.species == species)&&(identical(other.breed, breed) || other.breed == breed)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,species,breed,dateOfBirth,photoUrl,createdAt);
}

@override
String toString() {
    return 'PetDto(id: $id, name: $name, species: $species, breed: $breed, dateOfBirth: $dateOfBirth, photoUrl: $photoUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PetDtoCopyWith<$Res> implements $PetDtoCopyWith<$Res> {
  factory _$PetDtoCopyWith(_PetDto value, $Res Function(_PetDto) _then) = __$PetDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String species, String? breed, DateTime? dateOfBirth, String? photoUrl, DateTime createdAt
});




}
/// @nodoc
class __$PetDtoCopyWithImpl<$Res>
    implements _$PetDtoCopyWith<$Res> {
  __$PetDtoCopyWithImpl(this._self, this._then);

  final _PetDto _self;
  final $Res Function(_PetDto) _then;

/// Create a copy of PetDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? species = null,Object? breed = freezed,Object? dateOfBirth = freezed,Object? photoUrl = freezed,Object? createdAt = null,}) {
  return _then(_PetDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,breed: freezed == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CreatePetDto {

 String get name; String get species; String? get breed; DateTime? get dateOfBirth; String? get photoUrl;
/// Create a copy of CreatePetDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePetDtoCopyWith<CreatePetDto> get copyWith => _$CreatePetDtoCopyWithImpl<CreatePetDto>(this as CreatePetDto, _$identity);

  /// Serializes this CreatePetDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreatePetDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePetDto&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.species, _this.species) || other.species == _this.species)&&(identical(other.breed, _this.breed) || other.breed == _this.breed)&&(identical(other.dateOfBirth, _this.dateOfBirth) || other.dateOfBirth == _this.dateOfBirth)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreatePetDto;
  return Object.hash(runtimeType,_this.name,_this.species,_this.breed,_this.dateOfBirth,_this.photoUrl);
}

@override
String toString() {
  final _this = this as CreatePetDto;
  return 'CreatePetDto(name: ${_this.name}, species: ${_this.species}, breed: ${_this.breed}, dateOfBirth: ${_this.dateOfBirth}, photoUrl: ${_this.photoUrl})';
}


}

/// @nodoc
abstract mixin class $CreatePetDtoCopyWith<$Res>  {
  factory $CreatePetDtoCopyWith(CreatePetDto value, $Res Function(CreatePetDto) _then) = _$CreatePetDtoCopyWithImpl;
@useResult
$Res call({
 String name, String species, String? breed, DateTime? dateOfBirth, String? photoUrl
});




}
/// @nodoc
class _$CreatePetDtoCopyWithImpl<$Res>
    implements $CreatePetDtoCopyWith<$Res> {
  _$CreatePetDtoCopyWithImpl(this._self, this._then);

  final CreatePetDto _self;
  final $Res Function(CreatePetDto) _then;

/// Create a copy of CreatePetDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? species = null,Object? breed = freezed,Object? dateOfBirth = freezed,Object? photoUrl = freezed,}) {
  return _then(CreatePetDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,breed: freezed == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePetDto].
extension CreatePetDtoPatterns on CreatePetDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePetDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePetDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePetDto value)  $default,){
final _that = this;
switch (_that) {
case _CreatePetDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePetDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePetDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String species,  String? breed,  DateTime? dateOfBirth,  String? photoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePetDto() when $default != null:
return $default(_that.name,_that.species,_that.breed,_that.dateOfBirth,_that.photoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String species,  String? breed,  DateTime? dateOfBirth,  String? photoUrl)  $default,) {final _that = this;
switch (_that) {
case _CreatePetDto():
return $default(_that.name,_that.species,_that.breed,_that.dateOfBirth,_that.photoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String species,  String? breed,  DateTime? dateOfBirth,  String? photoUrl)?  $default,) {final _that = this;
switch (_that) {
case _CreatePetDto() when $default != null:
return $default(_that.name,_that.species,_that.breed,_that.dateOfBirth,_that.photoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePetDto implements CreatePetDto {
  const _CreatePetDto({required this.name, required this.species, this.breed, this.dateOfBirth, this.photoUrl});
  factory _CreatePetDto.fromJson(Map<String, dynamic> json) => _$CreatePetDtoFromJson(json);

@override final  String name;
@override final  String species;
@override final  String? breed;
@override final  DateTime? dateOfBirth;
@override final  String? photoUrl;

/// Create a copy of CreatePetDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePetDtoCopyWith<_CreatePetDto> get copyWith => __$CreatePetDtoCopyWithImpl<_CreatePetDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePetDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePetDto&&(identical(other.name, name) || other.name == name)&&(identical(other.species, species) || other.species == species)&&(identical(other.breed, breed) || other.breed == breed)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,species,breed,dateOfBirth,photoUrl);
}

@override
String toString() {
    return 'CreatePetDto(name: $name, species: $species, breed: $breed, dateOfBirth: $dateOfBirth, photoUrl: $photoUrl)';
}


}

/// @nodoc
abstract mixin class _$CreatePetDtoCopyWith<$Res> implements $CreatePetDtoCopyWith<$Res> {
  factory _$CreatePetDtoCopyWith(_CreatePetDto value, $Res Function(_CreatePetDto) _then) = __$CreatePetDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, String species, String? breed, DateTime? dateOfBirth, String? photoUrl
});




}
/// @nodoc
class __$CreatePetDtoCopyWithImpl<$Res>
    implements _$CreatePetDtoCopyWith<$Res> {
  __$CreatePetDtoCopyWithImpl(this._self, this._then);

  final _CreatePetDto _self;
  final $Res Function(_CreatePetDto) _then;

/// Create a copy of CreatePetDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? species = null,Object? breed = freezed,Object? dateOfBirth = freezed,Object? photoUrl = freezed,}) {
  return _then(_CreatePetDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,breed: freezed == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
