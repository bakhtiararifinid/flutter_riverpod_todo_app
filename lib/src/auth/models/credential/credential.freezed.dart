// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'credential.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Credential _$CredentialFromJson(Map<String, dynamic> json) {
  return _Credential.fromJson(json);
}

/// @nodoc
class _$CredentialTearOff {
  const _$CredentialTearOff();

  _Credential call({String? email, String? password}) {
    return _Credential(
      email: email,
      password: password,
    );
  }

  Credential fromJson(Map<String, Object?> json) {
    return Credential.fromJson(json);
  }
}

/// @nodoc
const $Credential = _$CredentialTearOff();

/// @nodoc
mixin _$Credential {
  String? get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CredentialCopyWith<Credential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialCopyWith<$Res> {
  factory $CredentialCopyWith(
          Credential value, $Res Function(Credential) then) =
      _$CredentialCopyWithImpl<$Res>;
  $Res call({String? email, String? password});
}

/// @nodoc
class _$CredentialCopyWithImpl<$Res> implements $CredentialCopyWith<$Res> {
  _$CredentialCopyWithImpl(this._value, this._then);

  final Credential _value;
  // ignore: unused_field
  final $Res Function(Credential) _then;

  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$CredentialCopyWith<$Res> implements $CredentialCopyWith<$Res> {
  factory _$CredentialCopyWith(
          _Credential value, $Res Function(_Credential) then) =
      __$CredentialCopyWithImpl<$Res>;
  @override
  $Res call({String? email, String? password});
}

/// @nodoc
class __$CredentialCopyWithImpl<$Res> extends _$CredentialCopyWithImpl<$Res>
    implements _$CredentialCopyWith<$Res> {
  __$CredentialCopyWithImpl(
      _Credential _value, $Res Function(_Credential) _then)
      : super(_value, (v) => _then(v as _Credential));

  @override
  _Credential get _value => super._value as _Credential;

  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_Credential(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Credential implements _Credential {
  _$_Credential({this.email, this.password});

  factory _$_Credential.fromJson(Map<String, dynamic> json) =>
      _$$_CredentialFromJson(json);

  @override
  final String? email;
  @override
  final String? password;

  @override
  String toString() {
    return 'Credential(email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Credential &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.password, password));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(password));

  @JsonKey(ignore: true)
  @override
  _$CredentialCopyWith<_Credential> get copyWith =>
      __$CredentialCopyWithImpl<_Credential>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CredentialToJson(this);
  }
}

abstract class _Credential implements Credential {
  factory _Credential({String? email, String? password}) = _$_Credential;

  factory _Credential.fromJson(Map<String, dynamic> json) =
      _$_Credential.fromJson;

  @override
  String? get email;
  @override
  String? get password;
  @override
  @JsonKey(ignore: true)
  _$CredentialCopyWith<_Credential> get copyWith =>
      throw _privateConstructorUsedError;
}
