// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TmdbResultImpl _$$TmdbResultImplFromJson(Map<String, dynamic> json) =>
    _$TmdbResultImpl(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => TMDBSingleResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$$TmdbResultImplToJson(_$TmdbResultImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

_$ResultImpl _$$ResultImplFromJson(Map<String, dynamic> json) => _$ResultImpl(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int,
      name: json['name'] as String?,
      originalLanguage: json['original_language'] as String?,
      originalName: json['original_name'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      mediaType: json['media_type'] as String?,
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      popularity: (json['popularity'] as num?)?.toDouble(),
      firstAirDate: json['first_air_date'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      title: json['title'] as String?,
      originalTitle: json['original_title'] as String?,
      releaseDate: json['release_date'] as String?,
      video: json['video'] as bool?,
    );

Map<String, dynamic> _$$ResultImplToJson(_$ResultImpl instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'id': instance.id,
      'name': instance.name,
      'original_language': instance.originalLanguage,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'media_type': instance.mediaType,
      'genre_ids': instance.genreIds,
      'popularity': instance.popularity,
      'first_air_date': instance.firstAirDate,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'origin_country': instance.originCountry,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'release_date': instance.releaseDate,
      'video': instance.video,
    };
