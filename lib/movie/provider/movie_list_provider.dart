// ignore_for_file: avoid_public_notifier_properties

import 'dart:async';

import 'package:anu3/movie/api/movie_repository.dart';
import 'package:anu3/movie/model/movie_model.dart';
import 'package:anu3/movie/model/user_movie_stats_model.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_list_provider.g.dart';

@Riverpod(keepAlive: true)
class MovieListNotifier extends _$MovieListNotifier {
  int _page = 1;
  int perPage = 3;
  bool hasMore = true;
  String searchQuery = "";
  Timer _timer = Timer(const Duration(milliseconds: 0), () {});
  List<UserMovieStatsModel> watched = [];

  @override
  FutureOr<List<MovieModel>> build() {
    return [];
  }

  Future<void> fetchMovies({
    int page = 1,
    required String groupId,
    bool resetValue = false,
    String searchQuery = "",
    String filter = "ALL",
  }) async {
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
            filter: filter
          );

      // updateWatchList(data.map((e) => e.id).toList());

      if (data.length < perPage) {
        hasMore = false;
      } else {
        hasMore = true;
        _page++;
      }

      if (kDebugMode) {
        print('original data');
        print(data);
      }

      // map the data
      var movieIds = data.map((e) => e.id).toList();
      var watched = await ref.read(movieRepositoryProvider).getWatchedMovies(movieIds: movieIds);
      var watchedMovieIds = watched.map((e) => e.movieId).toList();

      var newData = data.map((movie) {
        var hasWatched = watchedMovieIds.contains(movie.id);
        if (hasWatched) {
          return movie.copyWith(watchedList: watched.firstWhere((element) => element.movieId == movie.id));
        }
        return movie;
      }).toList();

      if (kDebugMode) {
        print('new data');
        print(newData);
      }

      if (resetValue) {
        return newData;
      }

      return state.value! + newData;
    });
  }

  bool checkIfWatched(int movieId) {
    bool check = watched.any((element) => element.movieId == movieId);
    if (kDebugMode) {
      print(watched);
      print(check);
    }
    return check;
  }

  Future<void> updateWatchList(List<int> movieIds) async {
    await ref.read(movieRepositoryProvider).getWatchedMovies(movieIds: movieIds).then((value) {
      if (kDebugMode) {
        print('update watchlist');
        print(value);
      }
      watched.addAll(value);
    });
  }

  Future<int?> toggleWatched(MovieModel movie) async {
    if (movie.watchedList != null) {
      // delete record
      if (kDebugMode) {
        print('delete record');
      }
      var value = await ref.read(movieRepositoryProvider).deleteWatchedMovies(model: movie.watchedList!);

      if (value == true) {
        var copy = movie.copyWith(watchedList: null);
        updateMovie(movie: copy);
        return 1;
      }
    } else {
      if (kDebugMode) {
        print('add record');
      }
      // add record
      var value = await ref.read(movieRepositoryProvider).addWatchedMovie(movieId: movie.id);

      if (value != null) {
        var copy = movie.copyWith(watchedList: value);
        updateMovie(movie: copy);
        return 2;
      }
    }
    return null;
  }

  Future<void> fetchNextPage({
    String query = "",
    required String groupId,
    String filter = "ALL"
  }) {
    if (hasMore) {
      fetchMovies(page: _page, groupId: groupId, filter: filter);
    }
    return Future.value();
  }

  Future<void> fetchFresh({String query = "", required String groupId, String filter = "ALL"}) {
    state = const AsyncValue.loading();
    _page = 1;
    hasMore = true;
    searchQuery = query;
    fetchMovies(
      page: _page,
      groupId: groupId,
      resetValue: true,
      searchQuery: query,
      filter: filter,
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
