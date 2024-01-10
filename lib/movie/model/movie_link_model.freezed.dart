// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_link_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MovieLinkModel _$MovieLinkModelFromJson(Map<String, dynamic> json) {
  return _MovieLinkModel.fromJson(json);
}

/// @nodoc
mixin _$MovieLinkModel {
  int get id => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;
  @JsonKey(name: 'movie_id')
  int get movieId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MovieLinkModelCopyWith<MovieLinkModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieLinkModelCopyWith<$Res> {
  factory $MovieLinkModelCopyWith(
          MovieLinkModel value, $Res Function(MovieLinkModel) then) =
      _$MovieLinkModelCopyWithImpl<$Res, MovieLinkModel>;
  @useResult
  $Res call(
      {int id,
      String link,
      @JsonKey(name: 'movie_id') int movieId,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$MovieLinkModelCopyWithImpl<$Res, $Val extends MovieLinkModel>
    implements $MovieLinkModelCopyWith<$Res> {
  _$MovieLinkModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? link = null,
    Object? movieId = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      movieId: null == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MovieLinkModelImplCopyWith<$Res>
    implements $MovieLinkModelCopyWith<$Res> {
  factory _$$MovieLinkModelImplCopyWith(_$MovieLinkModelImpl value,
          $Res Function(_$MovieLinkModelImpl) then) =
      __$$MovieLinkModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String link,
      @JsonKey(name: 'movie_id') int movieId,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$MovieLinkModelImplCopyWithImpl<$Res>
    extends _$MovieLinkModelCopyWithImpl<$Res, _$MovieLinkModelImpl>
    implements _$$MovieLinkModelImplCopyWith<$Res> {
  __$$MovieLinkModelImplCopyWithImpl(
      _$MovieLinkModelImpl _value, $Res Function(_$MovieLinkModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? link = null,
    Object? movieId = null,
    Object? createdAt = null,
  }) {
    return _then(_$MovieLinkModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      movieId: null == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MovieLinkModelImpl implements _MovieLinkModel {
  const _$MovieLinkModelImpl(
      {required this.id,
      required this.link,
      @JsonKey(name: 'movie_id') required this.movieId,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$MovieLinkModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieLinkModelImplFromJson(json);

  @override
  final int id;
  @override
  final String link;
  @override
  @JsonKey(name: 'movie_id')
  final int movieId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'MovieLinkModel(id: $id, link: $link, movieId: $movieId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieLinkModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.movieId, movieId) || other.movieId == movieId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, link, movieId, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieLinkModelImplCopyWith<_$MovieLinkModelImpl> get copyWith =>
      __$$MovieLinkModelImplCopyWithImpl<_$MovieLinkModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieLinkModelImplToJson(
      this,
    );
  }
}

abstract class _MovieLinkModel implements MovieLinkModel {
  const factory _MovieLinkModel(
          {required final int id,
          required final String link,
          @JsonKey(name: 'movie_id') required final int movieId,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$MovieLinkModelImpl;

  factory _MovieLinkModel.fromJson(Map<String, dynamic> json) =
      _$MovieLinkModelImpl.fromJson;

  @override
  int get id;
  @override
  String get link;
  @override
  @JsonKey(name: 'movie_id')
  int get movieId;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$MovieLinkModelImplCopyWith<_$MovieLinkModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
