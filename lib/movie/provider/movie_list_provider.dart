import 'package:anu3/movie/api/movie_repository.dart';
import 'package:anu3/movie/model/movie_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_list_provider.g.dart';

@Riverpod(keepAlive: true)
class MovieListNotifier extends _$MovieListNotifier {
  @override
  FutureOr<List<MovieModel>> build() {
    return [];
  }

  Future<void> fetchMovies({int page = 1, required String groupId}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(movieRepositoryProvider).getMovies(page: page, groupId: groupId));
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
