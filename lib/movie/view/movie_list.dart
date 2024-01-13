import 'package:anu3/auth/auth.dart';
import 'package:anu3/core/const.dart';
import 'package:anu3/movie/model/movie_model.dart';
import 'package:anu3/movie/provider/movie_list_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class MovieListPage extends ConsumerStatefulWidget {
  String groupId;
  MovieListPage({super.key, required this.groupId});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieListPageState();
}

class _MovieListPageState extends ConsumerState<MovieListPage> {
  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(movieListNotifierProvider);
    final user = ref.watch(authUserProvider).asData?.value;

    return RefreshIndicator(
      onRefresh: () => ref.read(movieListNotifierProvider.notifier).fetchMovies(groupId: widget.groupId),
      child: movies.when(
        data: (List<MovieModel> movies) {
          if (movies.isEmpty) {
            return NoMovieWidget(
              groupId: widget.groupId,
            );
          }
          return ListView(
            children: [
              for (final movie in movies)
                GestureDetector(
                  onTap: () {
                    // ignore: avoid_print
                    print(movie.id);
                    // context.pushNamed(
                    //   createGroupRoute,
                    //   queryParameters: {
                    //     'group_id': "${group.id}",
                    //   },
                    // );
                  },
                  child: ListTile(
                    title: Text(movie.title),
                    trailing: user?.id == movie.userId
                        ? PopupMenuButton<void Function()>(
                            offset: const Offset(10, 10),
                            padding: const EdgeInsets.all(0.0),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: () => {
                                    context.pushNamed(
                                      movieFormRoute,
                                      queryParameters: {
                                        'group_id': "${movie.groupId}",
                                        'movie_id': "${movie.id}",
                                      },
                                    )
                                  },
                                  child: const Text('Edit'),
                                ),
                                PopupMenuItem(
                                  value: () => ref.read(movieListNotifierProvider.notifier).deleteMovie(id: movie.id),
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
    );
  }
}


// ignore: must_be_immutable
class NoMovieWidget extends StatelessWidget {
  String groupId;
  NoMovieWidget({
    super.key,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No movies found.',
          ),
          const SizedBox(
            height: 5.0,
          ),
          TextButton(
            style: TextButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            onPressed: () {
              context.pushNamed(movieFormRoute, queryParameters: {'group_id': groupId});
              if (kDebugMode) {
                print('create group page');
              }
            },
            child: const Text("Add a new movie"),
          ),
        ],
      ),
    );
  }
}
