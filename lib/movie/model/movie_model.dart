import 'package:anu3/movie/model/user_movie_stats_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class MovieModel with _$MovieModel {
  const factory MovieModel({
    required int id,
    required String title,
    required String? poster,
    required double rating,
    required List<String> categories,
    @JsonKey(name: 'movie_user_stats') List<UserMovieStatsModel>? watchedList,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'user_name') required String userName,
    @JsonKey(name: 'group_id') required int groupId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);
}
