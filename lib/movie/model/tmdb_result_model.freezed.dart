// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tmdb_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TmdbResult _$TmdbResultFromJson(Map<String, dynamic> json) {
  return _TmdbResult.fromJson(json);
}

/// @nodoc
mixin _$TmdbResult {
  @JsonKey(name: "page")
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: "results")
  List<TMDBSingleResult> get results => throw _privateConstructorUsedError;
  @JsonKey(name: "total_pages")
  int get totalPages => throw _privateConstructorUsedError;
  @JsonKey(name: "total_results")
  int get totalResults => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TmdbResultCopyWith<TmdbResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TmdbResultCopyWith<$Res> {
  factory $TmdbResultCopyWith(
          TmdbResult value, $Res Function(TmdbResult) then) =
      _$TmdbResultCopyWithImpl<$Res, TmdbResult>;
  @useResult
  $Res call(
      {@JsonKey(name: "page") int page,
      @JsonKey(name: "results") List<TMDBSingleResult> results,
      @JsonKey(name: "total_pages") int totalPages,
      @JsonKey(name: "total_results") int totalResults});
}

/// @nodoc
class _$TmdbResultCopyWithImpl<$Res, $Val extends TmdbResult>
    implements $TmdbResultCopyWith<$Res> {
  _$TmdbResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? results = null,
    Object? totalPages = null,
    Object? totalResults = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<TMDBSingleResult>,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TmdbResultImplCopyWith<$Res>
    implements $TmdbResultCopyWith<$Res> {
  factory _$$TmdbResultImplCopyWith(
          _$TmdbResultImpl value, $Res Function(_$TmdbResultImpl) then) =
      __$$TmdbResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "page") int page,
      @JsonKey(name: "results") List<TMDBSingleResult> results,
      @JsonKey(name: "total_pages") int totalPages,
      @JsonKey(name: "total_results") int totalResults});
}

/// @nodoc
class __$$TmdbResultImplCopyWithImpl<$Res>
    extends _$TmdbResultCopyWithImpl<$Res, _$TmdbResultImpl>
    implements _$$TmdbResultImplCopyWith<$Res> {
  __$$TmdbResultImplCopyWithImpl(
      _$TmdbResultImpl _value, $Res Function(_$TmdbResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? results = null,
    Object? totalPages = null,
    Object? totalResults = null,
  }) {
    return _then(_$TmdbResultImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<TMDBSingleResult>,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TmdbResultImpl implements _TmdbResult {
  const _$TmdbResultImpl(
      {@JsonKey(name: "page") required this.page,
      @JsonKey(name: "results") required final List<TMDBSingleResult> results,
      @JsonKey(name: "total_pages") required this.totalPages,
      @JsonKey(name: "total_results") required this.totalResults})
      : _results = results;

  factory _$TmdbResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$TmdbResultImplFromJson(json);

  @override
  @JsonKey(name: "page")
  final int page;
  final List<TMDBSingleResult> _results;
  @override
  @JsonKey(name: "results")
  List<TMDBSingleResult> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  @JsonKey(name: "total_pages")
  final int totalPages;
  @override
  @JsonKey(name: "total_results")
  final int totalResults;

  @override
  String toString() {
    return 'TmdbResult(page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TmdbResultImpl &&
            (identical(other.page, page) || other.page == page) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, page,
      const DeepCollectionEquality().hash(_results), totalPages, totalResults);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TmdbResultImplCopyWith<_$TmdbResultImpl> get copyWith =>
      __$$TmdbResultImplCopyWithImpl<_$TmdbResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TmdbResultImplToJson(
      this,
    );
  }
}

abstract class _TmdbResult implements TmdbResult {
  const factory _TmdbResult(
      {@JsonKey(name: "page") required final int page,
      @JsonKey(name: "results") required final List<TMDBSingleResult> results,
      @JsonKey(name: "total_pages") required final int totalPages,
      @JsonKey(name: "total_results")
      required final int totalResults}) = _$TmdbResultImpl;

  factory _TmdbResult.fromJson(Map<String, dynamic> json) =
      _$TmdbResultImpl.fromJson;

  @override
  @JsonKey(name: "page")
  int get page;
  @override
  @JsonKey(name: "results")
  List<TMDBSingleResult> get results;
  @override
  @JsonKey(name: "total_pages")
  int get totalPages;
  @override
  @JsonKey(name: "total_results")
  int get totalResults;
  @override
  @JsonKey(ignore: true)
  _$$TmdbResultImplCopyWith<_$TmdbResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TMDBSingleResult _$TMDBSingleResultFromJson(Map<String, dynamic> json) {
  return _Result.fromJson(json);
}

/// @nodoc
mixin _$TMDBSingleResult {
  @JsonKey(name: "adult")
  bool? get adult => throw _privateConstructorUsedError;
  @JsonKey(name: "backdrop_path")
  String? get backdropPath => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "original_language")
  String? get originalLanguage => throw _privateConstructorUsedError;
  @JsonKey(name: "original_name")
  String? get originalName => throw _privateConstructorUsedError;
  @JsonKey(name: "overview")
  String? get overview => throw _privateConstructorUsedError;
  @JsonKey(name: "poster_path")
  String? get posterPath => throw _privateConstructorUsedError;
  @JsonKey(name: "media_type")
  String? get mediaType => throw _privateConstructorUsedError;
  @JsonKey(name: "genre_ids")
  List<int>? get genreIds => throw _privateConstructorUsedError;
  @JsonKey(name: "popularity")
  double? get popularity => throw _privateConstructorUsedError;
  @JsonKey(name: "first_air_date")
  String? get firstAirDate => throw _privateConstructorUsedError;
  @JsonKey(name: "vote_average")
  double? get voteAverage => throw _privateConstructorUsedError;
  @JsonKey(name: "vote_count")
  int? get voteCount => throw _privateConstructorUsedError;
  @JsonKey(name: "origin_country")
  List<String>? get originCountry => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: "original_title")
  String? get originalTitle => throw _privateConstructorUsedError;
  @JsonKey(name: "release_date")
  String? get releaseDate => throw _privateConstructorUsedError;
  @JsonKey(name: "video")
  bool? get video => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TMDBSingleResultCopyWith<TMDBSingleResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TMDBSingleResultCopyWith<$Res> {
  factory $TMDBSingleResultCopyWith(
          TMDBSingleResult value, $Res Function(TMDBSingleResult) then) =
      _$TMDBSingleResultCopyWithImpl<$Res, TMDBSingleResult>;
  @useResult
  $Res call(
      {@JsonKey(name: "adult") bool? adult,
      @JsonKey(name: "backdrop_path") String? backdropPath,
      @JsonKey(name: "id") int id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "original_language") String? originalLanguage,
      @JsonKey(name: "original_name") String? originalName,
      @JsonKey(name: "overview") String? overview,
      @JsonKey(name: "poster_path") String? posterPath,
      @JsonKey(name: "media_type") String? mediaType,
      @JsonKey(name: "genre_ids") List<int>? genreIds,
      @JsonKey(name: "popularity") double? popularity,
      @JsonKey(name: "first_air_date") String? firstAirDate,
      @JsonKey(name: "vote_average") double? voteAverage,
      @JsonKey(name: "vote_count") int? voteCount,
      @JsonKey(name: "origin_country") List<String>? originCountry,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "original_title") String? originalTitle,
      @JsonKey(name: "release_date") String? releaseDate,
      @JsonKey(name: "video") bool? video});
}

/// @nodoc
class _$TMDBSingleResultCopyWithImpl<$Res, $Val extends TMDBSingleResult>
    implements $TMDBSingleResultCopyWith<$Res> {
  _$TMDBSingleResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adult = freezed,
    Object? backdropPath = freezed,
    Object? id = null,
    Object? name = freezed,
    Object? originalLanguage = freezed,
    Object? originalName = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? mediaType = freezed,
    Object? genreIds = freezed,
    Object? popularity = freezed,
    Object? firstAirDate = freezed,
    Object? voteAverage = freezed,
    Object? voteCount = freezed,
    Object? originCountry = freezed,
    Object? title = freezed,
    Object? originalTitle = freezed,
    Object? releaseDate = freezed,
    Object? video = freezed,
  }) {
    return _then(_value.copyWith(
      adult: freezed == adult
          ? _value.adult
          : adult // ignore: cast_nullable_to_non_nullable
              as bool?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      originalLanguage: freezed == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      originalName: freezed == originalName
          ? _value.originalName
          : originalName // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaType: freezed == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String?,
      genreIds: freezed == genreIds
          ? _value.genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      popularity: freezed == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double?,
      firstAirDate: freezed == firstAirDate
          ? _value.firstAirDate
          : firstAirDate // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: freezed == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double?,
      voteCount: freezed == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int?,
      originCountry: freezed == originCountry
          ? _value.originCountry
          : originCountry // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      originalTitle: freezed == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResultImplCopyWith<$Res>
    implements $TMDBSingleResultCopyWith<$Res> {
  factory _$$ResultImplCopyWith(
          _$ResultImpl value, $Res Function(_$ResultImpl) then) =
      __$$ResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "adult") bool? adult,
      @JsonKey(name: "backdrop_path") String? backdropPath,
      @JsonKey(name: "id") int id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "original_language") String? originalLanguage,
      @JsonKey(name: "original_name") String? originalName,
      @JsonKey(name: "overview") String? overview,
      @JsonKey(name: "poster_path") String? posterPath,
      @JsonKey(name: "media_type") String? mediaType,
      @JsonKey(name: "genre_ids") List<int>? genreIds,
      @JsonKey(name: "popularity") double? popularity,
      @JsonKey(name: "first_air_date") String? firstAirDate,
      @JsonKey(name: "vote_average") double? voteAverage,
      @JsonKey(name: "vote_count") int? voteCount,
      @JsonKey(name: "origin_country") List<String>? originCountry,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "original_title") String? originalTitle,
      @JsonKey(name: "release_date") String? releaseDate,
      @JsonKey(name: "video") bool? video});
}

/// @nodoc
class __$$ResultImplCopyWithImpl<$Res>
    extends _$TMDBSingleResultCopyWithImpl<$Res, _$ResultImpl>
    implements _$$ResultImplCopyWith<$Res> {
  __$$ResultImplCopyWithImpl(
      _$ResultImpl _value, $Res Function(_$ResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adult = freezed,
    Object? backdropPath = freezed,
    Object? id = null,
    Object? name = freezed,
    Object? originalLanguage = freezed,
    Object? originalName = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? mediaType = freezed,
    Object? genreIds = freezed,
    Object? popularity = freezed,
    Object? firstAirDate = freezed,
    Object? voteAverage = freezed,
    Object? voteCount = freezed,
    Object? originCountry = freezed,
    Object? title = freezed,
    Object? originalTitle = freezed,
    Object? releaseDate = freezed,
    Object? video = freezed,
  }) {
    return _then(_$ResultImpl(
      adult: freezed == adult
          ? _value.adult
          : adult // ignore: cast_nullable_to_non_nullable
              as bool?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      originalLanguage: freezed == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      originalName: freezed == originalName
          ? _value.originalName
          : originalName // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaType: freezed == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String?,
      genreIds: freezed == genreIds
          ? _value._genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      popularity: freezed == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double?,
      firstAirDate: freezed == firstAirDate
          ? _value.firstAirDate
          : firstAirDate // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: freezed == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double?,
      voteCount: freezed == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int?,
      originCountry: freezed == originCountry
          ? _value._originCountry
          : originCountry // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      originalTitle: freezed == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResultImpl implements _Result {
  const _$ResultImpl(
      {@JsonKey(name: "adult") required this.adult,
      @JsonKey(name: "backdrop_path") required this.backdropPath,
      @JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "original_language") required this.originalLanguage,
      @JsonKey(name: "original_name") this.originalName,
      @JsonKey(name: "overview") required this.overview,
      @JsonKey(name: "poster_path") required this.posterPath,
      @JsonKey(name: "media_type") required this.mediaType,
      @JsonKey(name: "genre_ids") required final List<int>? genreIds,
      @JsonKey(name: "popularity") required this.popularity,
      @JsonKey(name: "first_air_date") this.firstAirDate,
      @JsonKey(name: "vote_average") required this.voteAverage,
      @JsonKey(name: "vote_count") required this.voteCount,
      @JsonKey(name: "origin_country") final List<String>? originCountry,
      @JsonKey(name: "title") this.title,
      @JsonKey(name: "original_title") this.originalTitle,
      @JsonKey(name: "release_date") this.releaseDate,
      @JsonKey(name: "video") this.video})
      : _genreIds = genreIds,
        _originCountry = originCountry;

  factory _$ResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResultImplFromJson(json);

  @override
  @JsonKey(name: "adult")
  final bool? adult;
  @override
  @JsonKey(name: "backdrop_path")
  final String? backdropPath;
  @override
  @JsonKey(name: "id")
  final int id;
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "original_language")
  final String? originalLanguage;
  @override
  @JsonKey(name: "original_name")
  final String? originalName;
  @override
  @JsonKey(name: "overview")
  final String? overview;
  @override
  @JsonKey(name: "poster_path")
  final String? posterPath;
  @override
  @JsonKey(name: "media_type")
  final String? mediaType;
  final List<int>? _genreIds;
  @override
  @JsonKey(name: "genre_ids")
  List<int>? get genreIds {
    final value = _genreIds;
    if (value == null) return null;
    if (_genreIds is EqualUnmodifiableListView) return _genreIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: "popularity")
  final double? popularity;
  @override
  @JsonKey(name: "first_air_date")
  final String? firstAirDate;
  @override
  @JsonKey(name: "vote_average")
  final double? voteAverage;
  @override
  @JsonKey(name: "vote_count")
  final int? voteCount;
  final List<String>? _originCountry;
  @override
  @JsonKey(name: "origin_country")
  List<String>? get originCountry {
    final value = _originCountry;
    if (value == null) return null;
    if (_originCountry is EqualUnmodifiableListView) return _originCountry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: "title")
  final String? title;
  @override
  @JsonKey(name: "original_title")
  final String? originalTitle;
  @override
  @JsonKey(name: "release_date")
  final String? releaseDate;
  @override
  @JsonKey(name: "video")
  final bool? video;

  @override
  String toString() {
    return 'TMDBSingleResult(adult: $adult, backdropPath: $backdropPath, id: $id, name: $name, originalLanguage: $originalLanguage, originalName: $originalName, overview: $overview, posterPath: $posterPath, mediaType: $mediaType, genreIds: $genreIds, popularity: $popularity, firstAirDate: $firstAirDate, voteAverage: $voteAverage, voteCount: $voteCount, originCountry: $originCountry, title: $title, originalTitle: $originalTitle, releaseDate: $releaseDate, video: $video)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultImpl &&
            (identical(other.adult, adult) || other.adult == adult) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.originalLanguage, originalLanguage) ||
                other.originalLanguage == originalLanguage) &&
            (identical(other.originalName, originalName) ||
                other.originalName == originalName) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            const DeepCollectionEquality().equals(other._genreIds, _genreIds) &&
            (identical(other.popularity, popularity) ||
                other.popularity == popularity) &&
            (identical(other.firstAirDate, firstAirDate) ||
                other.firstAirDate == firstAirDate) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            const DeepCollectionEquality()
                .equals(other._originCountry, _originCountry) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.originalTitle, originalTitle) ||
                other.originalTitle == originalTitle) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.video, video) || other.video == video));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        adult,
        backdropPath,
        id,
        name,
        originalLanguage,
        originalName,
        overview,
        posterPath,
        mediaType,
        const DeepCollectionEquality().hash(_genreIds),
        popularity,
        firstAirDate,
        voteAverage,
        voteCount,
        const DeepCollectionEquality().hash(_originCountry),
        title,
        originalTitle,
        releaseDate,
        video
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultImplCopyWith<_$ResultImpl> get copyWith =>
      __$$ResultImplCopyWithImpl<_$ResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResultImplToJson(
      this,
    );
  }
}

abstract class _Result implements TMDBSingleResult {
  const factory _Result(
      {@JsonKey(name: "adult") required final bool? adult,
      @JsonKey(name: "backdrop_path") required final String? backdropPath,
      @JsonKey(name: "id") required final int id,
      @JsonKey(name: "name") final String? name,
      @JsonKey(name: "original_language")
      required final String? originalLanguage,
      @JsonKey(name: "original_name") final String? originalName,
      @JsonKey(name: "overview") required final String? overview,
      @JsonKey(name: "poster_path") required final String? posterPath,
      @JsonKey(name: "media_type") required final String? mediaType,
      @JsonKey(name: "genre_ids") required final List<int>? genreIds,
      @JsonKey(name: "popularity") required final double? popularity,
      @JsonKey(name: "first_air_date") final String? firstAirDate,
      @JsonKey(name: "vote_average") required final double? voteAverage,
      @JsonKey(name: "vote_count") required final int? voteCount,
      @JsonKey(name: "origin_country") final List<String>? originCountry,
      @JsonKey(name: "title") final String? title,
      @JsonKey(name: "original_title") final String? originalTitle,
      @JsonKey(name: "release_date") final String? releaseDate,
      @JsonKey(name: "video") final bool? video}) = _$ResultImpl;

  factory _Result.fromJson(Map<String, dynamic> json) = _$ResultImpl.fromJson;

  @override
  @JsonKey(name: "adult")
  bool? get adult;
  @override
  @JsonKey(name: "backdrop_path")
  String? get backdropPath;
  @override
  @JsonKey(name: "id")
  int get id;
  @override
  @JsonKey(name: "name")
  String? get name;
  @override
  @JsonKey(name: "original_language")
  String? get originalLanguage;
  @override
  @JsonKey(name: "original_name")
  String? get originalName;
  @override
  @JsonKey(name: "overview")
  String? get overview;
  @override
  @JsonKey(name: "poster_path")
  String? get posterPath;
  @override
  @JsonKey(name: "media_type")
  String? get mediaType;
  @override
  @JsonKey(name: "genre_ids")
  List<int>? get genreIds;
  @override
  @JsonKey(name: "popularity")
  double? get popularity;
  @override
  @JsonKey(name: "first_air_date")
  String? get firstAirDate;
  @override
  @JsonKey(name: "vote_average")
  double? get voteAverage;
  @override
  @JsonKey(name: "vote_count")
  int? get voteCount;
  @override
  @JsonKey(name: "origin_country")
  List<String>? get originCountry;
  @override
  @JsonKey(name: "title")
  String? get title;
  @override
  @JsonKey(name: "original_title")
  String? get originalTitle;
  @override
  @JsonKey(name: "release_date")
  String? get releaseDate;
  @override
  @JsonKey(name: "video")
  bool? get video;
  @override
  @JsonKey(ignore: true)
  _$$ResultImplCopyWith<_$ResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
