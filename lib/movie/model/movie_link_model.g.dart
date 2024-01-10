// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_link_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieLinkModelImpl _$$MovieLinkModelImplFromJson(Map<String, dynamic> json) =>
    _$MovieLinkModelImpl(
      id: json['id'] as int,
      link: json['link'] as String,
      movieId: json['movie_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$MovieLinkModelImplToJson(
        _$MovieLinkModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
      'movie_id': instance.movieId,
      'created_at': instance.createdAt.toIso8601String(),
    };
