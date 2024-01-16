// ignore_for_file: avoid_public_notifier_properties
import 'dart:async';
import 'dart:ffi';

import 'package:anu3/group/api/group_repository.dart';
import 'package:anu3/group/group.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_list_notifier_provider.g.dart';

@Riverpod(keepAlive: true)
class GroupListNotifier extends _$GroupListNotifier {
  int _page = 1;
  int perPage = 10;
  bool hasMore = true;
  String searchQuery = "";
  Timer _timer = Timer(const Duration(milliseconds: 0), () {});

  @override
  Future<List<GroupModel>> build() async {
    return <GroupModel>[];
  }

  Future<void> fetchGroups({required int page, bool resetValue = false, String searchQuery = ""}) async {
    if (resetValue == false && _timer.isActive) {
      return;
    }

    if (hasMore == false) {
      return;
    }

    _timer = Timer(const Duration(milliseconds: 500), () {});

    state = await AsyncValue.guard(() async {
      var data = await ref.read(groupRepositoryProvider).getGroups(page: page, perPage: perPage, query: searchQuery);
      if (data.length < perPage) {
        hasMore = false;
      } else {
        hasMore = true;
        _page++;
      }

      if (resetValue) {
        return data;
      }

      return state.value! + data;
    });
  }

  Future<void> fetchNextPage({String query = ""}) {
    if (hasMore) {
      if (kDebugMode) {
        print(searchQuery);
      }
      fetchGroups(page: _page, searchQuery: query);
    }
    return Future.value();
  }

  Future<void> fetchFresh({String query = ""}) {
    state = const AsyncValue.loading();
    _page = 1;
    hasMore = true;
    searchQuery = query;
    fetchGroups(page: _page, resetValue: true, searchQuery: query);
    return Future.value();
  }

  Future<void> addGroup({
    required GroupModel group,
  }) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      return [group, ...state.value!];
    });
  }

  Future<void> updateGroup({
    required GroupModel group,
  }) async {
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      return state.value!.map((e) => e.id == group.id ? e.copyWith(name: group.name, visibility: group.visibility) : e).toList();
    });
  }

  Future<void> deleteGroup({
    required int id,
  }) async {
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      bool deleted = await ref.read(groupRepositoryProvider).deleteGroup(groupId: id);
      if (deleted) {
        if (state.value!.length < perPage) {
          fetchFresh();
        }
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
