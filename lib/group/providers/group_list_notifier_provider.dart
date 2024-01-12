// ignore_for_file: avoid_public_notifier_properties
import 'package:anu3/group/api/group_repository.dart';
import 'package:anu3/group/group.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_list_notifier_provider.g.dart';

@Riverpod(keepAlive: true)
class GroupListNotifier extends _$GroupListNotifier {
  int _page = 1;
  int perPage = 3;
  bool hasMore = true;

  @override
  Future<List<GroupModel>> build() async {
    // _fetchGroups(page: 1);
    return <GroupModel>[];
  }

  Future<void> fetchGroups({required int page, bool resetValue = false}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      var data = await ref.read(groupRepositoryProvider).getGroups(page: page, perPage: perPage);
      if (data.length < perPage) {
        hasMore = false;
      } else {
        hasMore = true;
      }
      _page++;

      if (resetValue) {
        return data;
      }

      return state.value! + data;
    });
  }

  void fetchNextPage() {
    if (hasMore) {
      fetchGroups(page: _page);
    }
  }

  Future<void> fetchFresh() {
    _page = 1;
    hasMore = true;
    fetchGroups(page: _page, resetValue: true);
    return Future.value();
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

  Future<void> updateGroup({
    required String id,
    required String name,
    required bool visibility,
  }) async {
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      bool updated = await ref.read(groupRepositoryProvider).updateGroup(groupId: id, name: name, visibility: visibility);
      if (updated) {
        return state.value!.map((e) => e.id == int.parse(id) ? e.copyWith(name: name, visibility: visibility) : e).toList();
      } else {
        return state.value!;
      }
    });
  }

  Future<void> deleteGroup({
    required int id,
  }) async {
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      bool deleted = await ref.read(groupRepositoryProvider).deleteGroup(groupId: id);
      if (deleted) {
        return state.value!.where((element) => element.id != id).toList();
      } else {
        return state.value!;
      }
    });
  }

  GroupModel getGroupById(int groupId) {
    return state.value!.firstWhere((element) => element.id == groupId);
  }
}
