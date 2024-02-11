import 'package:anu3/movie/model/movie_link_model.dart';
import 'package:anu3/movie/model/movie_model.dart';
import 'package:anu3/movie/model/user_movie_stats_model.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'movie_repository.g.dart';

@riverpod
MovieRepository movieRepository(MovieRepositoryRef _) => MovieRepository();

class MovieRepository {
  final _client = Supabase.instance.client;

  Future<List<MovieModel>> getMovies({int page = 1, required String groupId, String query = '', int perPage = 10, String filter = "ALL"}) async {
    if (filter == "PENDING") {
      // todo: get pending movies
      return getPendingMoviesByUserByGroup(groupId: groupId, page: page, query: query, perPage: perPage);
    }

    if (filter == "WATCHED") {
      // todo: get watched movies
      return getWatchedMoviesByUserByGroup(groupId: groupId, page: page, query: query, perPage: perPage);
    }

    return getAllMovies(groupId: groupId, page: page, query: query, perPage: perPage);
  }

  Future<List<MovieModel>> getAllMovies({
    int page = 1,
    required String groupId,
    String query = '',
    int perPage = 10,
  }) async {
    final userId = _client.auth.currentSession?.user.id;
    final from = (page - 1) * perPage;
    final to = page * perPage;

    if (userId == null) {
      throw 'Not logged in';
    }
    query = '%$query%';
    final response =
        await _client.from('movies').select("*").ilike('title', query).eq('group_id', groupId).range(from, to).order('id', ascending: false);
    if (kDebugMode) {
      print(response.toString());
    }

    return response.map<MovieModel>((json) => MovieModel.fromJson(json)).toList();
  }

  Future<List<MovieModel>> getWatchedMoviesByUserByGroup({
    int page = 1,
    required String groupId,
    String query = '',
    int perPage = 10,
  }) async {
    final userId = _client.auth.currentSession?.user.id;
    final from = (page - 1) * perPage;
    final to = page * perPage;

    if (userId == null) {
      throw 'Not logged in';
    }

    final watchedMovies = await _client.from('movie_user_stats').select('*').eq('user_id', userId);
    final watchedMovieIds =
        watchedMovies.map<UserMovieStatsModel>((json) => UserMovieStatsModel.fromJson(json)).toList().map((e) => e.movieId).toList();

    if (kDebugMode) {
      print(watchedMovies);
      print(watchedMovieIds);
    }

    query = '%$query%';
    final response = await _client
        .from('movies')
        .select("*")
        .inFilter('id', watchedMovieIds)
        .ilike('title', query)
        .eq('group_id', groupId)
        .range(from, to)
        .order('id', ascending: false);
    if (kDebugMode) {
      print(response.toString());
    }

    return response.map<MovieModel>((json) => MovieModel.fromJson(json)).toList();
  }

  Future<List<MovieModel>> getPendingMoviesByUserByGroup({
    int page = 1,
    required String groupId,
    String query = '',
    int perPage = 10,
  }) async {
    final userId = _client.auth.currentSession?.user.id;
    final from = (page - 1) * perPage;
    final to = page * perPage;

    if (userId == null) {
      throw 'Not logged in';
    }

    final watchedMovies = await _client.from('movie_user_stats').select('*').eq('user_id', userId);
    final watchedMovieIds =
        watchedMovies.map<UserMovieStatsModel>((json) => UserMovieStatsModel.fromJson(json)).toList().map((e) => e.movieId).toList();

    if (kDebugMode) {
      print(watchedMovies);
      print(watchedMovieIds);
    }

    query = '%$query%';
    final response = await _client
        .from('movies')
        .select("*")
        .not('id', 'in', watchedMovieIds)
        .ilike('title', query)
        .eq('group_id', groupId)
        .range(from, to)
        .order('id', ascending: false);

    if (kDebugMode) {
      print(response.toString());
    }

    return response.map<MovieModel>((json) => MovieModel.fromJson(json)).toList();
  }

  Future<List<UserMovieStatsModel>> getWatchedMovies({required List<int> movieIds}) async {
    final userId = _client.auth.currentSession?.user.id;
    final response = await _client.from('movie_user_stats').select('*').eq('user_id', userId!).inFilter('movie_id', movieIds.toList());
    return response.map<UserMovieStatsModel>((json) => UserMovieStatsModel.fromJson(json)).toList();
  }

  Future<UserMovieStatsModel?> addWatchedMovie({required int movieId}) async {
    late UserMovieStatsModel model;
    final userId = _client.auth.currentSession?.user.id;
    final response = await _client.from('movie_user_stats').insert({'movie_id': movieId, 'user_id': userId!}).select();
    if (response.isNotEmpty) {
      model = UserMovieStatsModel.fromJson(response[0]);
    }
    return model;
  }

  Future<bool> deleteWatchedMovies({required UserMovieStatsModel model}) async {
    try {
      await _client.from('movie_user_stats').delete().match({'id': model.id});
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<List<MovieLinkModel>> getLinks({required int movieId}) async {
    final response = await _client.from('movie_links').select('*').eq('movie_id', movieId);
    return response.map<MovieLinkModel>((json) => MovieLinkModel.fromJson(json)).toList();
  }

  Future<MovieModel?> addMovie({
    required String title,
    String? poster,
    required double rating,
    required List categories,
    required String groupId,
    required List<MovieLinkModel> links,
  }) async {
    late MovieModel? movieModel;
    final userId = _client.auth.currentSession?.user.id;
    final userName = _client.auth.currentSession?.user.userMetadata?['name'];
    if (userId == null) {
      throw 'Not logged in';
    }

    if (kDebugMode) {
      print(links);
    }

    try {
      final response = await _client.from('movies').insert({
        'title': title,
        'poster': poster,
        'rating': rating,
        'categories': categories,
        'user_id': userId,
        'user_name': userName,
        'group_id': groupId,
      }).select();

      if (kDebugMode) {
        print(response);
      }

      if (response.isNotEmpty) {
        movieModel = MovieModel.fromJson(response[0]);

        if (kDebugMode) {
          print(movieModel);
        }

        // build movie_links model
        var links0 = links
            .map((e) => {
                  'movie_id': movieModel?.id,
                  'link': e.link,
                })
            .toList();
        if (kDebugMode) {
          print('links0');
          print(links0);
        }
        var linksResponse = await _client.from('movie_links').insert(links0).select();

        if (kDebugMode) {
          print('linksResponse');
          print(linksResponse);
        }

        return movieModel;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      if (movieModel != null) {
        // delete the movie
        await _client.from('movies').delete().match({'id': movieModel.id});
      }

      throw "Could not add movie";
    }

    return null;
  }

  Future<MovieModel?> updateMovie({
    required int id,
    required String title,
    String? poster,
    required double rating,
    required List categories,
    required List<MovieLinkModel> links,
  }) async {
    late MovieModel? movieModel;

    if (kDebugMode) {
      print(links);
    }

    try {
      final response = await _client.from('movies').update({
        'title': title,
        'poster': poster,
        'rating': rating,
        'categories': categories,
      }).match({'id': id}).select();

      if (kDebugMode) {
        print('response');
        print(response);
      }

      if (response.isNotEmpty) {
        movieModel = MovieModel.fromJson(response[0]);

        if (kDebugMode) {
          print(movieModel);
        }

        // get the current links
        var movieLinks = await getLinks(movieId: id);

        if (kDebugMode) {
          print('movieLinks');
          print(movieLinks);
        }

        if (links.isNotEmpty) {
          var links0 = links.map((e) {
            return e.id != null ? {'id': e.id, 'link': e.link, 'movie_id': e.movieId} : {'link': e.link, 'movie_id': id};
          }).toList();
          // upsert links
          if (kDebugMode) {
            print('links to upsert');
            print(links0);
          }
          var linksResponse = await _client.from('movie_links').upsert(links0, onConflict: 'id', defaultToNull: false).select();

          if (kDebugMode) {
            print(linksResponse);
          }
        }

        return movieModel;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw "Could not update movie";
    }

    return null;
  }

  Future<bool> deleteMovieLink({required int id}) async {
    try {
      var deleted = await _client.from('movie_links').delete().match({'id': id});
      if (kDebugMode) {
        print(deleted);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> deleteMovie({required int movieId}) async {
    try {
      var deleted = await _client.from('movies').delete().match({'id': movieId});
      if (kDebugMode) {
        print(deleted);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
