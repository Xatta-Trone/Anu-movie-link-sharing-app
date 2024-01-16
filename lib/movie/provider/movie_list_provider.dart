// ignore_for_file: avoid_public_notifier_properties

import 'dart:async';

import 'package:anu3/movie/api/movie_repository.dart';
import 'package:anu3/movie/model/movie_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_list_provider.g.dart';

@Riverpod(keepAlive: true)
class MovieListNotifier extends _$MovieListNotifier {
  int _page = 1;
  int perPage = 3;
  bool hasMore = true;
  String searchQuery = "";
  Timer _timer = Timer(const Duration(milliseconds: 0), () {});

  @override
  FutureOr<List<MovieModel>> build() {
    return [];
  }

  Future<void> fetchMovies({int page = 1, required String groupId, bool resetValue = false, String searchQuery = ""}) async {
    if (resetValue == false && _timer.isActive) {
      return;
    }

    if (hasMore == false) {
      return;
    }

    _timer = Timer(const Duration(milliseconds: 500), () {});

    state = await AsyncValue.guard(() async {
      var data = await ref.read(movieRepositoryProvider).getMovies(
            page: page,
            groupId: groupId,
            query: searchQuery,
            perPage: perPage,
          );

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

  Future<void> fetchNextPage({
    String query = "",
    required String groupId,
  }) {
    if (hasMore) {
      fetchMovies(page: _page, groupId: groupId);
    }
    return Future.value();
  }

  Future<void> fetchFresh({String query = "", required String groupId}) {
    state = const AsyncValue.loading();
    _page = 1;
    hasMore = true;
    searchQuery = query;
    fetchMovies(
      page: _page,
      groupId: groupId,
      resetValue: true,
      searchQuery: query,
    );
    return Future.value();
  }

  Future<void> addMovie({
    required MovieModel movie,
  }) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      return [movie, ...state.value!];
    });
  }

  Future<void> updateMovie({
    required MovieModel movie,
  }) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      return state.value!.map((e) => e.id == movie.id ? movie : e).toList();
    });
  }

  Future<void> deleteMovie({
    required int id,
  }) async {
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      bool deleted = await ref.read(movieRepositoryProvider).deleteMovie(movieId: id);
      if (deleted) {
        return state.value!.where((element) => element.id != id).toList();
      } else {
        return state.value!;
      }
    });
  }

  MovieModel getMovieById(int id) {
    return state.value!.firstWhere((element) => element.id == id);
  }
}
