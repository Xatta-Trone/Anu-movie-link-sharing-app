import 'dart:io';

import 'package:anu3/group/api/group_repository.dart';
import 'package:anu3/group/group.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_list_notifier_provider.g.dart';

@Riverpod(keepAlive: true)
class GroupListNotifier extends _$GroupListNotifier {
  int _page = 1;

  @override
  Future<List<GroupModel>> build() async {
    _fetchGroups(page: 1);
    return <GroupModel>[];
  }

  Future<void> _fetchGroups({int page = 1}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(groupRepositoryProvider).getGroups(page: page));
  }

  Future<void> addGroup({
    required String name,
    required bool visibility,
  }) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      var newModel = await ref.read(groupRepositoryProvider).addGroup(name: name, visibility: visibility);
      if (newModel != null) {
        return [newModel, ...state.value!];
      } else {
        return state.value!;
      }
    });
  }
}
