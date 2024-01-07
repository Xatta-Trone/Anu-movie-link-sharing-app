import 'package:anu3/core/core.dart';
import 'package:anu3/group/group.dart';
import 'package:anu3/group/providers/group_list_notifier_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GroupHomePage extends ConsumerWidget {
  const GroupHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(groupListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ANU'),
        elevation: 8.0,
      ),
      body: groups.when(
        data: (List<GroupModel> groups) {
          if (groups.isEmpty) {
            return const NoGroupWidget();
          }

          return ListView(
            children: [for (final group in groups) ListTile(title: Text(group.name))],
          );
        },
        error: (Object error, StackTrace stackTrace) => Text('Error: $error'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class NoGroupWidget extends StatelessWidget {
  const NoGroupWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'You have no groups',
          ),
          const SizedBox(
            height: 5.0,
          ),
          TextButton(
            style: TextButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            onPressed: () {
              context.pushNamed(createGroupRoute);
              if (kDebugMode) {
                print('create group page');
              }
            },
            child: const Text("Create a group"),
          ),
          TextButton(
            style: TextButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            onPressed: () {
              if (kDebugMode) {
                print('Join group page');
              }
            },
            child: const Text("Join a group"),
          ),
        ],
      ),
    );
  }
}
