import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_movie_stats_model.freezed.dart';
part 'user_movie_stats_model.g.dart';

@freezed
class UserMovieStatsModel with _$UserMovieStatsModel {
  const factory UserMovieStatsModel({
    required int id,
    @JsonKey(name: 'has_watched') required bool hasWatched,
    @JsonKey(name: 'movie_id') required int movieId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _UserMovieStatsModel;

  factory UserMovieStatsModel.fromJson(Map<String, dynamic> json) => _$UserMovieStatsModelFromJson(json);
}
