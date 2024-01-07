import 'package:anu3/core/core.dart';
import 'package:anu3/group/api/group_repository.dart';
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

    // Let's render the todos in a scrollable list view
    return groups.when(
      data: (List<GroupModel> data) {
        return ListView(
          children: [for (final todo in data) ListTile(title: Text(todo.name))],
        );
      },
      error: (Object error, StackTrace stackTrace) => Text('Error: $error'),
      loading: () => const SafeArea(
          child: Center(
              child: CircularProgressIndicator(
        color: Color.fromRGBO(0, 0, 0, 1),
      ))),
    );
    return switch (groups) {
      AsyncData(:final value) => ListView(
          children: [for (final todo in value) ListTile(title: Text(todo.name))],
        ),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const Center(
          child: Text('loading....'),
        ),
    };
        
    return Scaffold(
        appBar: AppBar(
          title: const Text('ANU'),
          elevation: 8.0,
        ),
      body: NoGroupWidget(ref: ref),
    );
  }
}

class NoGroupWidget extends StatelessWidget {
  const NoGroupWidget({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

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
          TextButton(
            style: TextButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            onPressed: () {
              ref.read(groupRepositoryProvider).getGroups();
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
