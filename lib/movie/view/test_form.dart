import 'package:anu3/core/debouncer.dart';
import 'package:anu3/movie/model/tmdb_result_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TestForm extends ConsumerStatefulWidget {
  const TestForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestFormState();
}

class TestModel {
  String name;
  int age;
  TestModel({required this.name, required this.age});
}

class _TestFormState extends ConsumerState<TestForm> {
  List<TestModel> values = [];
  TMDBSingleResult? selected;

  List<TMDBSingleResult> _listMovies = List<TMDBSingleResult>.empty(growable: true);

  final _debouncer = Debouncer(milliseconds: 500);
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _textEditingController.addListener(() {
    //   _onQueryChanged();
    // });
  }

  void _onQueryChanged() async {
    if (selected == null && _textEditingController.text.isNotEmpty) {
      _debouncer.run(() {
        getValues(query: _textEditingController.text);
      });
    }
  }

  executeQuery({query = ""}) async {
    _debouncer.run(() async {
      return getValues(query: query);
    });
  }

  getValues({query = ""}) async {
    if (selected != null) {
      return;
    }

    setState(() {
      // _listMovies.clear();
      selected = null;
    });

    // setState(() {
    //   _listMovies.clear();
    // });
    // Future.delayed(const Duration(seconds: 0), () {
    //   setState(() {
    //     values.addAll([
    //       TestModel(name: 'aaaa', age: 22),
    //       TestModel(name: 'bbb', age: 23),
    //       TestModel(name: 'ccc', age: 24),
    //       TestModel(name: 'ddd', age: 25),
    //     ]);
    //   });
    // });

    var dio = Dio();
    var token = dotenv.env['TMDB_KEY'] ?? '';
    dio.options.headers["Authorization"] = "Bearer $token";

    await dio.get("https://api.themoviedb.org/3/search/multi?query=$query&include_adult=false&language=en-US&page=1").then((response) {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        TmdbResult result = TmdbResult.fromJson(response.data);
        if (kDebugMode) {
          print(result.totalPages);
        }

        setState(() {
          _listMovies.addAll(result.results);
        });
      }
      // return _listMovies;
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('test'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Autocomplete<TMDBSingleResult>(
              displayStringForOption: (option) => option.mediaType == 'movie'
                  ? "${option.title!} (${option.mediaType}) - ${option.releaseDate}"
                  : "${option.name!} (${option.mediaType}) - ${option.firstAirDate}",
              optionsBuilder: (TextEditingValue value) async {
                if (kDebugMode) {
                  print('value.text');
                  print(selected);
                  print(value.text);
                }
                if (selected != null || value.text.isEmpty) {
                  return [];
                } else {
                  _debouncer.run(() async {
                    setState(() {
                      selected = null;
                      _listMovies.clear();
                    });
                    await getValues(query: value.text);
                  });

                  return _listMovies;
                }
              },
              fieldViewBuilder: (BuildContext context, TextEditingController controller, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                return TextFormField(
                  focusNode: focusNode,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Movie name (year)',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                );
              },
              onSelected: (option) {
                setState(() {
                  selected = option;
                });

                if (kDebugMode) {
                  print('onselected');
                  print(selected);
                }
              },
              optionsMaxHeight: MediaQuery.of(context).size.height * 0.33,
            ),
            const SizedBox(height: 16),
            // TextFormField(),
            TypeAheadField<TMDBSingleResult>(
              suggestionsCallback: (search) async {
                if (kDebugMode) {
                  print(search);
                }
                if (search.isEmpty) {
                  return [];
                } else {
                  _debouncer.run(() async {
                    setState(() {
                      _listMovies.clear();
                      selected = null;
                    });
                    await getValues(query: search);
                  });
                  return _listMovies;
                }
              },
              builder: (context, controller, focusNode) {
                return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    autofocus: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'City',
                    ));
              },
              itemBuilder: (context, movie) {
                return ListTile(
                  title: Text(movie.name ?? movie.title!),
                );
              },
              onSelected: (movie) {
                setState(() {
                  selected = movie;
                });

                if (kDebugMode) {
                  print(selected);
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
