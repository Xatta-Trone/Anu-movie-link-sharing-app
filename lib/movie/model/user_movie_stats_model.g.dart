// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_movie_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserMovieStatsModelImpl _$$UserMovieStatsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserMovieStatsModelImpl(
      id: json['id'] as int,
      hasWatched: json['has_watched'] as bool,
      movieId: json['movie_id'] as int,
      userId: json['user_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$UserMovieStatsModelImplToJson(
        _$UserMovieStatsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'has_watched': instance.hasWatched,
      'movie_id': instance.movieId,
      'user_id': instance.userId,
      'created_at': instance.createdAt.toIso8601String(),
    };
