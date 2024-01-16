// To parse this JSON data, do
//
//     final tmdbResult = tmdbResultFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'tmdb_result_model.freezed.dart';
part 'tmdb_result_model.g.dart';

TmdbResult tmdbResultFromJson(String str) => TmdbResult.fromJson(json.decode(str));

String tmdbResultToJson(TmdbResult data) => json.encode(data.toJson());

@freezed
class TmdbResult with _$TmdbResult {
  const factory TmdbResult({
    @JsonKey(name: "page") required int page,
    @JsonKey(name: "results") required List<TMDBSingleResult> results,
    @JsonKey(name: "total_pages") required int totalPages,
    @JsonKey(name: "total_results") required int totalResults,
  }) = _TmdbResult;

  factory TmdbResult.fromJson(Map<String, dynamic> json) => _$TmdbResultFromJson(json);
}

@freezed
class TMDBSingleResult with _$TMDBSingleResult {
  const factory TMDBSingleResult({
    @JsonKey(name: "adult") required bool? adult,
    @JsonKey(name: "backdrop_path") required String? backdropPath,
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "original_language") required String? originalLanguage,
    @JsonKey(name: "original_name") String? originalName,
    @JsonKey(name: "overview") required String? overview,
    @JsonKey(name: "poster_path") required String? posterPath,
    @JsonKey(name: "media_type") required String? mediaType,
    @JsonKey(name: "genre_ids") required List<int>? genreIds,
    @JsonKey(name: "popularity") required double? popularity,
    @JsonKey(name: "first_air_date") String? firstAirDate,
    @JsonKey(name: "vote_average") required double? voteAverage,
    @JsonKey(name: "vote_count") required int? voteCount,
    @JsonKey(name: "origin_country") List<String>? originCountry,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "original_title") String? originalTitle,
    @JsonKey(name: "release_date") String? releaseDate,
    @JsonKey(name: "video") bool? video,
  }) = _Result;

  factory TMDBSingleResult.fromJson(Map<String, dynamic> json) => _$TMDBSingleResultFromJson(json);
}
