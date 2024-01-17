import 'package:anu3/core/dio.dart';
import 'package:anu3/movie/model/tmdb_result_model.dart';
import 'package:anu3/movie/model/tmdb_single_movie_result.dart';
import 'package:anu3/movie/model/tmdb_single_tv_result.dart';
import 'package:flutter/foundation.dart';

class TMDBRepository {
  TMDBRepository();

  Future<List<TMDBSingleResult>?> searchKeywords({query = ""}) async {
    var dio = Api().dio;

    var res = await dio.get("/3/search/multi?query=$query&include_adult=false&language=en-US&page=1");

    if (res.statusCode == 200) {
      TmdbResult result = TmdbResult.fromJson(res.data);

      if (kDebugMode) {
        print(result.totalPages);
      }
      var returnResults = result.results.where((element) => element.mediaType == "movie" || element.mediaType == "tv");
      if (kDebugMode) {
        print('returnResults.length');
        print(returnResults.length);
      }

      return returnResults.toList();
    }
    return null;
  }

  Future<List<String>> getGenres(TMDBSingleResult model) async {
    var dio = Api().dio;
    String url = "/3/${model.mediaType}/${model.id}";
    var res = await dio.get(url);
    late TmdbSingleTvResult tvResult;
    late TmdbSingleMovieResult movieResult;

    if (res.statusCode == 200) {
      if (model.mediaType == "tv") {
        tvResult = TmdbSingleTvResult.fromJson(res.data);
        return tvResult.genres!.map((e) => e.name!).toList();
      }
      if (model.mediaType == "movie") {
        movieResult = TmdbSingleMovieResult.fromJson(res.data);
        return movieResult.genres!.map((e) => e.name!).toList();
      }
      return [];
    }
    return [];
  }
}
