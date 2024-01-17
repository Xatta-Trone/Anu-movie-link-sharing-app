// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_movie_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserMovieStatsModel _$UserMovieStatsModelFromJson(Map<String, dynamic> json) {
  return _UserMovieStatsModel.fromJson(json);
}

/// @nodoc
mixin _$UserMovieStatsModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_watched')
  bool get hasWatched => throw _privateConstructorUsedError;
  @JsonKey(name: 'movie_id')
  int get movieId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserMovieStatsModelCopyWith<UserMovieStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserMovieStatsModelCopyWith<$Res> {
  factory $UserMovieStatsModelCopyWith(
          UserMovieStatsModel value, $Res Function(UserMovieStatsModel) then) =
      _$UserMovieStatsModelCopyWithImpl<$Res, UserMovieStatsModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'has_watched') bool hasWatched,
      @JsonKey(name: 'movie_id') int movieId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$UserMovieStatsModelCopyWithImpl<$Res, $Val extends UserMovieStatsModel>
    implements $UserMovieStatsModelCopyWith<$Res> {
  _$UserMovieStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hasWatched = null,
    Object? movieId = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      hasWatched: null == hasWatched
          ? _value.hasWatched
          : hasWatched // ignore: cast_nullable_to_non_nullable
              as bool,
      movieId: null == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserMovieStatsModelImplCopyWith<$Res>
    implements $UserMovieStatsModelCopyWith<$Res> {
  factory _$$UserMovieStatsModelImplCopyWith(_$UserMovieStatsModelImpl value,
          $Res Function(_$UserMovieStatsModelImpl) then) =
      __$$UserMovieStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'has_watched') bool hasWatched,
      @JsonKey(name: 'movie_id') int movieId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$UserMovieStatsModelImplCopyWithImpl<$Res>
    extends _$UserMovieStatsModelCopyWithImpl<$Res, _$UserMovieStatsModelImpl>
    implements _$$UserMovieStatsModelImplCopyWith<$Res> {
  __$$UserMovieStatsModelImplCopyWithImpl(_$UserMovieStatsModelImpl _value,
      $Res Function(_$UserMovieStatsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hasWatched = null,
    Object? movieId = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_$UserMovieStatsModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      hasWatched: null == hasWatched
          ? _value.hasWatched
          : hasWatched // ignore: cast_nullable_to_non_nullable
              as bool,
      movieId: null == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserMovieStatsModelImpl implements _UserMovieStatsModel {
  const _$UserMovieStatsModelImpl(
      {required this.id,
      @JsonKey(name: 'has_watched') required this.hasWatched,
      @JsonKey(name: 'movie_id') required this.movieId,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$UserMovieStatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserMovieStatsModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'has_watched')
  final bool hasWatched;
  @override
  @JsonKey(name: 'movie_id')
  final int movieId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'UserMovieStatsModel(id: $id, hasWatched: $hasWatched, movieId: $movieId, userId: $userId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserMovieStatsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hasWatched, hasWatched) ||
                other.hasWatched == hasWatched) &&
            (identical(other.movieId, movieId) || other.movieId == movieId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, hasWatched, movieId, userId, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserMovieStatsModelImplCopyWith<_$UserMovieStatsModelImpl> get copyWith =>
      __$$UserMovieStatsModelImplCopyWithImpl<_$UserMovieStatsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserMovieStatsModelImplToJson(
      this,
    );
  }
}

abstract class _UserMovieStatsModel implements UserMovieStatsModel {
  const factory _UserMovieStatsModel(
          {required final int id,
          @JsonKey(name: 'has_watched') required final bool hasWatched,
          @JsonKey(name: 'movie_id') required final int movieId,
          @JsonKey(name: 'user_id') required final String userId,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$UserMovieStatsModelImpl;

  factory _UserMovieStatsModel.fromJson(Map<String, dynamic> json) =
      _$UserMovieStatsModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'has_watched')
  bool get hasWatched;
  @override
  @JsonKey(name: 'movie_id')
  int get movieId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$UserMovieStatsModelImplCopyWith<_$UserMovieStatsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
