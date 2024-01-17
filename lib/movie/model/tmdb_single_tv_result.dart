// To parse this JSON data, do
//
//     final tmdbSingleTvResult = tmdbSingleTvResultFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'tmdb_single_tv_result.freezed.dart';
part 'tmdb_single_tv_result.g.dart';

TmdbSingleTvResult tmdbSingleTvResultFromJson(String str) => TmdbSingleTvResult.fromJson(json.decode(str));

String tmdbSingleTvResultToJson(TmdbSingleTvResult data) => json.encode(data.toJson());

@freezed
class TmdbSingleTvResult with _$TmdbSingleTvResult {
  const factory TmdbSingleTvResult({
    @JsonKey(name: "adult") bool? adult,
    @JsonKey(name: "backdrop_path") String? backdropPath,
    @JsonKey(name: "created_by") List<CreatedBy>? createdBy,
    @JsonKey(name: "episode_run_time") List<dynamic>? episodeRunTime,
    @JsonKey(name: "first_air_date") DateTime? firstAirDate,
    @JsonKey(name: "genres") List<Genre>? genres,
    @JsonKey(name: "homepage") String? homepage,
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "in_production") bool? inProduction,
    @JsonKey(name: "languages") List<String>? languages,
    @JsonKey(name: "last_air_date") DateTime? lastAirDate,
    @JsonKey(name: "last_episode_to_air") LastEpisodeToAir? lastEpisodeToAir,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "next_episode_to_air") dynamic nextEpisodeToAir,
    @JsonKey(name: "networks") List<Network>? networks,
    @JsonKey(name: "number_of_episodes") int? numberOfEpisodes,
    @JsonKey(name: "number_of_seasons") int? numberOfSeasons,
    @JsonKey(name: "origin_country") List<String>? originCountry,
    @JsonKey(name: "original_language") String? originalLanguage,
    @JsonKey(name: "original_name") String? originalName,
    @JsonKey(name: "overview") String? overview,
    @JsonKey(name: "popularity") double? popularity,
    @JsonKey(name: "poster_path") String? posterPath,
    @JsonKey(name: "production_companies") List<Network>? productionCompanies,
    @JsonKey(name: "production_countries") List<ProductionCountry>? productionCountries,
    @JsonKey(name: "seasons") List<Season>? seasons,
    @JsonKey(name: "spoken_languages") List<SpokenLanguage>? spokenLanguages,
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "tagline") String? tagline,
    @JsonKey(name: "type") String? type,
    @JsonKey(name: "vote_average") double? voteAverage,
    @JsonKey(name: "vote_count") int? voteCount,
  }) = _TmdbSingleTvResult;

  factory TmdbSingleTvResult.fromJson(Map<String, dynamic> json) => _$TmdbSingleTvResultFromJson(json);
}

@freezed
class CreatedBy with _$CreatedBy {
  const factory CreatedBy({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "credit_id") String? creditId,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "gender") int? gender,
    @JsonKey(name: "profile_path") String? profilePath,
  }) = _CreatedBy;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => _$CreatedByFromJson(json);
}

@freezed
class Genre with _$Genre {
  const factory Genre({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "name") String? name,
  }) = _Genre;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}

@freezed
class LastEpisodeToAir with _$LastEpisodeToAir {
  const factory LastEpisodeToAir({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "overview") String? overview,
    @JsonKey(name: "vote_average") double? voteAverage,
    @JsonKey(name: "vote_count") int? voteCount,
    @JsonKey(name: "air_date") DateTime? airDate,
    @JsonKey(name: "episode_number") int? episodeNumber,
    @JsonKey(name: "episode_type") String? episodeType,
    @JsonKey(name: "production_code") String? productionCode,
    @JsonKey(name: "runtime") int? runtime,
    @JsonKey(name: "season_number") int? seasonNumber,
    @JsonKey(name: "show_id") int? showId,
    @JsonKey(name: "still_path") String? stillPath,
  }) = _LastEpisodeToAir;

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) => _$LastEpisodeToAirFromJson(json);
}

@freezed
class Network with _$Network {
  const factory Network({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "logo_path") String? logoPath,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "origin_country") String? originCountry,
  }) = _Network;

  factory Network.fromJson(Map<String, dynamic> json) => _$NetworkFromJson(json);
}

@freezed
class ProductionCountry with _$ProductionCountry {
  const factory ProductionCountry({
    @JsonKey(name: "iso_3166_1") String? iso31661,
    @JsonKey(name: "name") String? name,
  }) = _ProductionCountry;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) => _$ProductionCountryFromJson(json);
}

@freezed
class Season with _$Season {
  const factory Season({
    @JsonKey(name: "air_date") DateTime? airDate,
    @JsonKey(name: "episode_count") int? episodeCount,
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "overview") String? overview,
    @JsonKey(name: "poster_path") String? posterPath,
    @JsonKey(name: "season_number") int? seasonNumber,
    @JsonKey(name: "vote_average") double? voteAverage,
  }) = _Season;

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
}

@freezed
class SpokenLanguage with _$SpokenLanguage {
  const factory SpokenLanguage({
    @JsonKey(name: "english_name") String? englishName,
    @JsonKey(name: "iso_639_1") String? iso6391,
    @JsonKey(name: "name") String? name,
  }) = _SpokenLanguage;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => _$SpokenLanguageFromJson(json);
}
