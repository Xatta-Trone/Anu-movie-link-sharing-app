import 'package:anu3/core/core.dart';
import 'package:anu3/group/group.dart';
import 'package:anu3/group/providers/group_list_notifier_provider.dart';
import 'package:anu3/movie/provider/movie_list_provider.dart';
import 'package:anu3/movie/view/movie_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class GroupDetailPage extends ConsumerStatefulWidget {
  String? groupId;
  GroupDetailPage({super.key, this.groupId});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends ConsumerState<GroupDetailPage> {
  late GroupModel group;

  @override
  void initState() {
    super.initState();
    if (widget.groupId != null) {
      if (kDebugMode) {
        print(widget.groupId);
      }
      group = ref.read(groupListNotifierProvider.notifier).getGroupById(int.parse(widget.groupId!));

      Future.delayed(
        Duration.zero,
        () => ref.read(movieListNotifierProvider.notifier).fetchMovies(
              groupId: widget.groupId!,
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${group.name} - ${group.code}',
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            onPressed: () => context.pushNamed(
              movieFormRoute,
              queryParameters: {
                'group_id': "${group.id}",
              },
            ),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: MovieListPage(
        groupId: "${group.id}",
      ),
    );
  }
}
