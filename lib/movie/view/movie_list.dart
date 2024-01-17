import 'dart:ui';

import 'package:anu3/auth/auth.dart';
import 'package:anu3/core/const.dart';
import 'package:anu3/core/debouncer.dart';
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
  final _scrollController = ScrollController();
  final _queryController = TextEditingController();

  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => ref.read(movieListNotifierProvider.notifier).fetchFresh(
            groupId: widget.groupId,
          ),
    );
    _scrollController.addListener(_loadMore);
    _queryController.addListener(_onQueryChanged);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _queryController.dispose();
    super.dispose();
  }

  void _onQueryChanged() {
    _debouncer.run(() {
      if (kDebugMode) {
        print(_queryController.text);
      }
      ref.read(movieListNotifierProvider.notifier).fetchFresh(
            groupId: widget.groupId,
            query: _queryController.text,
          );
    });
  }

  void _loadMore() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (kDebugMode) {
        print('Loading next batch');
      }
      ref.read(movieListNotifierProvider.notifier).fetchNextPage(
            groupId: widget.groupId,
            query: _queryController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(movieListNotifierProvider);
    final user = ref.watch(authUserProvider).asData?.value;
    final notifier = ref.read(movieListNotifierProvider.notifier);

    return RefreshIndicator(
      onRefresh: () => notifier.fetchFresh(groupId: widget.groupId),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _queryController,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                suffixIcon: IconButton(
                  onPressed: () => _queryController.clear(),
                  icon: const Icon(Icons.cancel_rounded),
                ),
              ),
            ),
          ),
          movies.when(
            data: (List<MovieModel> movies) {
              if (movies.isEmpty) {
                return Flexible(
                  child: NoMovieWidget(
                    groupId: widget.groupId,
                    queryController: _queryController,
                  ),
                );
              }
              return Flexible(
                child: ListView(
                  controller: _scrollController,
                  children: [
                    for (final movie in movies)
                      GestureDetector(
                        onTap: () {
                          if (kDebugMode) {
                            print(movie.id);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            image: DecorationImage(
                              alignment: movie.poster != null ? Alignment.topCenter : Alignment.center,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                movie.poster != null
                                    ? 'https://image.tmdb.org/t/p/w500/${movie.poster}'
                                    : 'https://placehold.co/400x400/34495e/FFF.png?text=No%20Image',
                              ),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.4),
                                  Colors.black.withOpacity(.3),
                                ],
                              ),
                            ),
                            child: Stack(
                              children: [
                                Text(
                                  movie.title,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                  textScaler: const TextScaler.linear(1.35),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Row(
                                    children: [
                                      Center(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 6.0,
                                                vertical: 3.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Icon(
                                                    Icons.trending_up_outlined,
                                                    size: 16.0,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(width: 2.0),
                                                  Text(
                                                    movie.rating.toString(),
                                                    style: const TextStyle(color: Colors.white),
                                                    textScaler: const TextScaler.linear(0.85),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      for (var cat in movie.categories) ...[CategoryChip(text: cat.trim())]
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Row(
                                    children: [
                                      if (user?.id == movie.userId) ...[
                                        PopupMenuButton<void Function()>(
                                          iconColor: Colors.white,
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
                                                child: const Text('Edit media'),
                                              ),
                                              PopupMenuItem(
                                                value: () => ref.read(movieListNotifierProvider.notifier).deleteMovie(id: movie.id),
                                                child: const Text('Delete media'),
                                              ),
                                            ];
                                          },
                                          onSelected: (fn) => fn(),
                                        )
                                      ],
                                      GestureDetector(
                                        onTap: () {
                                          if (kDebugMode) {
                                            print('clicked');
                                          }
                                        },
                                        child: const Icon(
                                          Icons.bookmark_add_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    notifier.hasMore
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Column(
                                children: [
                                  const Text('End of list'),
                                  TextButton(
                                    style: TextButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                                    onPressed: () => notifier.fetchFresh(groupId: widget.groupId),
                                    child: const Text("Refresh data"),
                                  ),
                                ],
                              ),
                            ),
                          )
                  ],
                ),
              );
            },
            error: (Object error, StackTrace stackTrace) => Text('Error: $error'),
            loading: () => const Flexible(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
        
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 4.0),
      child: Center(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 3.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: const TextStyle(color: Colors.white),
                    textScaler: const TextScaler.linear(0.85),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class NoMovieWidget extends StatelessWidget {
  String groupId;
  final TextEditingController queryController;
  NoMovieWidget({
    super.key,
    required this.groupId,
    required this.queryController
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
          TextButton(
            style: TextButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            onPressed: () {
              queryController.clear();
            },
            child: const Text("Refresh data"),
          ),
        ],
      ),
    );
  }
}
