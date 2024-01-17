import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org'));

  Api._internal();
  static final _singleton = Api._internal();
  factory Api() => _singleton;

  static Dio createDio() {
    var token = dotenv.env['TMDB_KEY'] ?? '';
    var dio = Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org', headers: {'Accept': 'application/json'}));
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.interceptors.addAll({
      // AuthInterceptor(),
      // UAInterceptor(),
      // ApiVersionInterceptor(),
    });
    return dio;
  }
}
