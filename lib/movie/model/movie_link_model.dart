import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_link_model.freezed.dart';
part 'movie_link_model.g.dart';

@freezed
class MovieLinkModel with _$MovieLinkModel {
  const factory MovieLinkModel({
    required int id,
    required String link,
    @JsonKey(name: 'movie_id') required int movieId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _MovieLinkModel;

  factory MovieLinkModel.fromJson(Map<String, dynamic> json) => _$MovieLinkModelFromJson(json);
}
