import 'package:anu3/auth/auth.dart';
import 'package:anu3/core/core.dart';
import 'package:anu3/group/group.dart';
import 'package:anu3/group/providers/group_list_notifier_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GroupHomePage extends ConsumerStatefulWidget {
  const GroupHomePage({super.key});

  @override
  ConsumerState<GroupHomePage> createState() => _GroupHomePageState();
}

class _GroupHomePageState extends ConsumerState<GroupHomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => ref.read(groupListNotifierProvider.notifier).fetchFresh());
    _scrollController.addListener(_loadMore);
  }

  void _loadMore() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (kDebugMode) {
        print('Loading next batch');
      }
      ref.read(groupListNotifierProvider.notifier).fetchNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groups = ref.watch(groupListNotifierProvider);
    final user = ref.watch(authUserProvider).asData?.value;
    final notifier = ref.read(groupListNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 10.0),
            onPressed: () => context.pushNamed(createGroupRoute),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   key: const Key('group-floating-action'),
      //   onPressed: () {
      //     context.pushNamed(createGroupRoute);
      //   },
      //   child: const Icon(Icons.add_circle_outline),
      // ),
      body: RefreshIndicator(
        onRefresh: () => notifier.fetchFresh(),
        child: groups.when(
          data: (List<GroupModel> groups) {
            if (groups.isEmpty) {
              return const NoGroupWidget();
            }

            return ListView.builder(
              controller: _scrollController,
              itemCount: groups.length + 1,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: (index == groups.length)
                    ? notifier.hasMore
                        ? const Center(child: CircularProgressIndicator())
                        : const Center(child: Text('End of list'))
                    : GestureDetector(
                        onTap: () {
                          if (kDebugMode) {
                            print(groups[index].id);
                          }
                          context.pushNamed(
                            groupDetailsRoute,
                            queryParameters: {
                              'group_id': "${groups[index].id}",
                            },
                          );
                        },
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                            ),
                            child: const Icon(Icons.workspaces),
                          ),
                          title: Text(
                            groups[index].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Container(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Row(
                              children: [
                                GroupChipWidget(
                                  text: groups[index].visibility ? 'Public' : 'Private',
                                ),
                                const SizedBox(width: 8.0),
                                const GroupChipWidget(
                                  text: '100 people',
                                ),
                                const SizedBox(width: 8.0),
                                const GroupChipWidget(
                                  text: '50 movies',
                                ),
                              ],
                            ),
                          ),
                          trailing: user?.id == groups[index].userId
                              ? PopupMenuButton<void Function()>(
                                  padding: const EdgeInsets.all(0.0),
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        value: () => context.pushNamed(
                                          createGroupRoute,
                                          queryParameters: {
                                            'group_id': "${groups[index].id}",
                                          },
                                        ),
                                        child: const Text('Edit group'),
                                      ),
                                      PopupMenuItem(
                                        value: () => notifier.deleteGroup(id: groups[index].id),
                                        child: const Text('Delete group'),
                                      ),
                                      PopupMenuItem(
                                        value: () {
                                          Clipboard.setData(ClipboardData(text: groups[index].code));
                                        },
                                        child: const Text('Copy group code'),
                                      ),
                                    ];
                                  },
                                  onSelected: (fn) => fn(),
                                )
                              : null,
                        ),
                      ),
              ),
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

class GroupChipWidget extends StatelessWidget {
  final String text;
  const GroupChipWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Text(
        text,
        textScaler: const TextScaler.linear(0.85),
      ),
    );
  }
}

class NoGroupWidget extends ConsumerWidget {
  const NoGroupWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              ref.read(groupListNotifierProvider.notifier).fetchFresh();
            },
            child: const Text("Refresh data"),
          ),
        ],
      ),
    );
  }
}
