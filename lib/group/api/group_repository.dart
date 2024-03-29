import 'package:anu3/core/core.dart';
import 'package:anu3/group/group.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'group_repository.g.dart';

@riverpod
GroupRepository groupRepository(GroupRepositoryRef _) => GroupRepository();

class GroupRepository {
  final _client = Supabase.instance.client;

  var groups = <GroupModel>[];
  int currentPage = 1;

  Future<List<GroupModel>> getGroups({int page = 1, int perPage = 3, String query = ""}) async {
    final userId = _client.auth.currentSession?.user.id;
    final from = (page - 1) * perPage;
    final to = page * perPage - 1;

    if (userId == null) {
      throw 'Not logged in';
    }

    if (kDebugMode) {
      print(page);
      print(query);
    }

    query = '%$query%';

    if (kDebugMode) {
      print(query);
    }
    final response = await _client
        .from('groups')
        .select('*, group_user!inner()')
        .ilike('name', query)
        .eq('group_user.user_id', userId)
        .range(from, to)
        .order('id', ascending: false);
    if (kDebugMode) {
      print('response');
      print(query);
      print(response.toString());
    }

    return response.map<GroupModel>((json) => GroupModel.fromJson(json)).toList();
  }

  Future<GroupModel?> addGroup({
    required String name,
    required bool visibility,
  }) async {
    final userId = _client.auth.currentSession?.user.id;

    if (kDebugMode) {
      print(userId);
    }

    if (userId == null) {
      throw 'Not logged in';
    }

    var groupCode = generateRandomString(6);
    var exists = true;

    // check the unique code
    do {
      final res = await _client.from('groups').select('name').eq('code', groupCode).count(CountOption.exact);
      if (res.count > 0) {
        groupCode = generateRandomString(6);
        exists = true;
      } else {
        exists = false;
      }
    } while (exists == true);

    try {
      final response = await _client.from('groups').insert({
        'name': name,
        'visibility': visibility,
        'user_id': userId,
        'code': groupCode,
      }).select();

      if (kDebugMode) {
        print(response);
      }

      if (response.isNotEmpty) {
        final groupModel = GroupModel.fromJson(response[0]);
        addMemberToGroup(groupId: groupModel.id.toString(), memberId: userId, isAdmin: true, isPending: false);
        return groupModel;
      }

      if (kDebugMode) {
        print(response[0]);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      if (e.toString().contains('duplicate key value violates unique constraint "groups_code_key"')) {
        throw "Group code already exists";
      } else {
        throw "An error occurred creating the group";
      }
    }
    return null;
  }

  Future<GroupModel?> updateGroup({
    required String groupId,
    required String name,
    required bool visibility,
  }) async {
    late GroupModel? group;
    try {
      final response = await _client.from('groups').update({
        'name': name,
        'visibility': visibility,
      }).match({
        'id': groupId,
      }).select();
      if (response.isNotEmpty) {
        group = GroupModel.fromJson(response[0]);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
    return group;
  }

  Future<GroupModel?> joinGroup({required String groupCode}) async {
    late GroupModel? group;
    try {
      final res = await _client.from('groups').select().match({'code': groupCode});

      if (res.isEmpty) {
        throw "Group not found";
      }

      group = GroupModel.fromJson(res[0]);

      final userId = _client.auth.currentSession?.user.id;

      if (userId == null) {
        throw 'Not logged in';
      }

      await addMemberToGroup(groupId: group.id.toString(), memberId: userId);

      return group;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addMemberToGroup({required String groupId, required String memberId, bool isAdmin = false, bool isPending = true}) async {
    try {
      final res = await _client.from('group_user').select('id').eq('user_id', memberId).eq('group_id', groupId).count(CountOption.exact);

      if (kDebugMode) {
        print(res.count);
      }

      if (res.count > 0) {
        throw "User already in group";
      }

      final response = await _client.from('group_user').insert({
        'user_id': memberId,
        'group_id': groupId,
        'is_admin': isAdmin,
        'is_pending': isPending,
      }).select();

      if (kDebugMode) {
        print(response.toString());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  Future<bool> deleteGroup({required int groupId}) async {
    try {
      var deleted = await _client.from('groups').delete().match({'id': groupId});
      if (kDebugMode) {
        print(deleted);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
