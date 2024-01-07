import 'package:anu3/auth/auth.dart';
import 'package:anu3/core/core.dart';
import 'package:anu3/group/group.dart';
import 'package:anu3/group/providers/group_list_notifier_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GroupHomePage extends ConsumerStatefulWidget {
  const GroupHomePage({super.key});

  @override
  ConsumerState<GroupHomePage> createState() => _GroupHomePageState();
}

class _GroupHomePageState extends ConsumerState<GroupHomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => ref.read(groupListNotifierProvider.notifier).fetchGroups());
  }

  @override
  Widget build(BuildContext context) {
    final groups = ref.watch(groupListNotifierProvider);
    final user = ref.watch(authUserProvider).asData?.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ANU'),
        elevation: 8.0,
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('group-floating-action'),
        onPressed: () {
          context.pushNamed(createGroupRoute);
        },
        child: const Icon(Icons.add_circle_outline),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(groupListNotifierProvider.notifier).fetchGroups(),
        child: groups.when(
          data: (List<GroupModel> groups) {
            if (groups.isEmpty) {
              return const NoGroupWidget();
            }
            return ListView(
              children: [
                for (final group in groups)
                  GestureDetector(
                    onTap: user?.id == group.userId
                        ? () {
                            // ignore: avoid_print
                            print(group.id);
                            // context.pushNamed(
                            //   createGroupRoute,
                            //   queryParameters: {
                            //     'group_id': "${group.id}",
                            //   },
                            // );
                          }
                        : null,
                    child: ListTile(
                      title: Text("${group.name} | ${group.visibility ? 'Public' : 'Private'}"),
                      trailing: user?.id == group.userId
                          ? PopupMenuButton<void Function()>(
                              offset: const Offset(10, 10),
                              padding: const EdgeInsets.all(0.0),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    value: () => context.pushNamed(
                                      createGroupRoute,
                                      queryParameters: {
                                        'group_id': "${group.id}",
                                      },
                                    ),
                                    child: const Text('Edit'),
                                  ),
                                  PopupMenuItem(
                                    value: () => ref.read(groupListNotifierProvider.notifier).deleteGroup(id: group.id),
                                    child: const Text('Delete'),
                                  ),
                                ];
                              },
                              onSelected: (fn) => fn(),
                            )
                          : null,
                    ),
                  )
              ],
            );
          },
          error: (Object error, StackTrace stackTrace) => Text('Error: $error'),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
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
