// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieModelImpl _$$MovieModelImplFromJson(Map<String, dynamic> json) =>
    _$MovieModelImpl(
      id: json['id'] as int,
      title: json['title'] as String,
      poster: json['poster'] as String?,
      rating: (json['rating'] as num).toDouble(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      watchedList: (json['movie_user_stats'] as List<dynamic>?)
          ?.map((e) => UserMovieStatsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      groupId: json['group_id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$MovieModelImplToJson(_$MovieModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster': instance.poster,
      'rating': instance.rating,
      'categories': instance.categories,
      'movie_user_stats': instance.watchedList,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'group_id': instance.groupId,
      'created_at': instance.createdAt.toIso8601String(),
    };
