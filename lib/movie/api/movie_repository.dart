import 'package:anu3/movie/model/movie_link_model.dart';
import 'package:anu3/movie/model/movie_model.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'movie_repository.g.dart';

@riverpod
MovieRepository movieRepository(MovieRepositoryRef _) => MovieRepository();

class MovieRepository {
  final _client = Supabase.instance.client;

  Future<List<MovieModel>> getMovies({
    int page = 1,
    required String groupId,
  }) async {
    final userId = _client.auth.currentSession?.user.id;

    const perPage = 10;
    final from = (page - 1) * perPage;
    final to = page * perPage;

    if (userId == null) {
      throw 'Not logged in';
    }

    final response = await _client.from('movies').select('*').eq('group_id', groupId).range(from, to).order('id', ascending: false);
    if (kDebugMode) {
      print(response.toString());
    }

    return response.map<MovieModel>((json) => MovieModel.fromJson(json)).toList();
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
    required List links,
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
                  'link': e,
                })
            .toList();
        final linksResponse = await _client.from('movie_links').insert(links0).select();

        if (kDebugMode) {
          print(linksResponse);
          print(links0);
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
