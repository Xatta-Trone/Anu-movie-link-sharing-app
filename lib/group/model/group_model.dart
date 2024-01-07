import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_model.freezed.dart';
part 'group_model.g.dart';

@freezed
class GroupModel with _$GroupModel {
  const factory GroupModel({
    required int id,
    required String name,
    required String code,
    required bool visibility,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _GroupModel;

  factory GroupModel.fromJson(Map<String, Object?> json) => _$GroupModelFromJson(json);
}
