import 'package:anu3/group/group.dart';
import 'package:anu3/group/providers/group_list_notifier_provider.dart';
import 'package:anu3/movie/api/movie_repository.dart';
import 'package:anu3/movie/api/tmdb_repository.dart';
import 'package:anu3/movie/model/movie_link_model.dart';
import 'package:anu3/movie/model/movie_model.dart';
import 'package:anu3/movie/model/tmdb_result_model.dart';
import 'package:anu3/movie/provider/movie_list_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class MovieFormPage extends ConsumerStatefulWidget {
  String? groupId;
  String? movieId;
  MovieFormPage({super.key, this.groupId, this.movieId});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieFormPageState();
}

class _MovieFormPageState extends ConsumerState<MovieFormPage> {
  late GroupModel group;

  @override
  initState() {
    super.initState();
    if (widget.groupId != null) {
      if (kDebugMode) {
        print(widget.groupId);
      }
      group = ref.read(groupListNotifierProvider.notifier).getGroupById(int.parse(widget.groupId!));
    }

    if (widget.movieId != null) {
      if (kDebugMode) {
        print("movie id ${widget.movieId}");
      }
      MovieModel movie = ref.read(movieListNotifierProvider.notifier).getMovieById(int.parse(widget.movieId!));

      if (kDebugMode) {
        print(movie);
      }

      _movieName.text = movie.title;
      _movieCategories.text = movie.categories.join(',');
      _moviePoster.text = movie.poster ?? ''.toString();
      _movieRating.text = movie.rating.toString();

      _addLinks(movie.id);
    } else {
      _movieLinks.add(const MovieLinkModel(link: ''));
    }
  }

  Future<void> _addLinks(int movieId) async {
    List<MovieLinkModel> links = await ref.read(movieRepositoryProvider).getLinks(movieId: movieId);
    if (kDebugMode) {
      print(links.map((e) => e.link).toList());
    }
    setState(() {
      _movieLinks.addAll(links);
    });

    if (kDebugMode) {
      print(_movieLinks);
    }
  }

  // movie form
  final _formKey = GlobalKey<FormState>();
  final _movieName = TextEditingController();
  final _movieCategories = TextEditingController();
  final _moviePoster = TextEditingController();
  final _movieRating = TextEditingController();
  final _movieLinks = List<MovieLinkModel>.empty(growable: true);
  bool _isSubmitting = false;

  handleSubmit(BuildContext context) {
    setState(() {
      _isSubmitting = true;
    });
    if (widget.movieId != null) {
      return handleUpdate(context);
    } else {
      return handleCreate(context);
    }
  }

  handleCreate(BuildContext context) {
    // create movie
    ScaffoldMessenger.of(context).clearSnackBars();

    try {
      ref
          .read(movieRepositoryProvider)
          .addMovie(
            title: _movieName.text,
            rating: double.parse(_movieRating.text).toDouble(),
            categories: _movieCategories.text.split(','),
            groupId: widget.groupId!,
            links: _movieLinks,
            poster: _moviePoster.text == '' ? null : _moviePoster.text,
          )
          .then(
        (value) {
          ref.read(movieListNotifierProvider.notifier).addMovie(movie: value!);

          if (mounted) {
            context.pop();
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Movie created...')),
          );

          _formKey.currentState!.reset();
        },
      ).catchError((error) {
        if (kDebugMode) {
          print(error);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error creating group')),
      );
    }

    setState(() {
      _isSubmitting = false;
    });
  }

  handleUpdate(BuildContext context) {
    // create movie
    ScaffoldMessenger.of(context).clearSnackBars();

    try {
      ref
          .read(movieRepositoryProvider)
          .updateMovie(
            id: int.parse(widget.movieId!),
            title: _movieName.text,
            rating: double.parse(_movieRating.text).toDouble(),
            categories: _movieCategories.text.split(','),
            links: _movieLinks,
            poster: _moviePoster.text == '' ? null : _moviePoster.text,
          )
          .then(
        (value) {
          if (kDebugMode) {
            print(value);
          }
          ref.read(movieListNotifierProvider.notifier).updateMovie(movie: value!);

          if (mounted) {
            context.pop();
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Movie updated...')),
          );

          _formKey.currentState!.reset();
        },
      ).catchError((error) {
        if (kDebugMode) {
          print(error);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error updating group')),
      );
    }

    setState(() {
      _isSubmitting = false;
    });
  }

  void removeLink(int index, BuildContext context) {
    if (_movieLinks[index].id != null) {
      ref.read(movieRepositoryProvider).deleteMovieLink(id: _movieLinks[index].id!).then((value) {
        ScaffoldMessenger.of(context).clearSnackBars();
        if (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Link deleted')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not delete the link')),
          );
        }
      });
    }

    setState(() {
      _movieLinks.removeAt(index);
    });
  }

  final List<TMDBSingleResult> _listMovies = List<TMDBSingleResult>.empty(growable: true);
  TMDBSingleResult? selected;

  searchQuery({String query = ""}) async {
    var values = await TMDBRepository().searchKeywords(query: query.trim());

    if (kDebugMode) {
      print('values');
      print(values!.length);
    }

    setState(() {
      selected = null;
      _listMovies.addAll(values as Iterable<TMDBSingleResult>);
    });

    return _listMovies;
  }

  String _posterPath = '';
  setSelected(TMDBSingleResult value) async {
    if (kDebugMode) {
      print('selected');
      print(value);
    }

    String title = value.mediaType == 'tv' ? value.name! : value.title!;
    title += " ";
    title += value.mediaType == 'tv' ? "(${value.firstAirDate!.substring(0, 4)})" : "(${value.releaseDate!.substring(0, 4)})";

    setState(() {
      selected = value;
      _movieName.text = title;
      _moviePoster.text = "https://image.tmdb.org/t/p/w500/${value.backdropPath!}";
      _posterPath = "https://image.tmdb.org/t/p/w500/${value.posterPath!}";
      _movieRating.text = value.voteAverage!.toStringAsFixed(1).toString();
    });

    // get the categories
    var categories = await TMDBRepository().getGenres(value);

    setState(() {
      _movieCategories.text = categories.join(', ');
    });
  }

  @override
  void dispose() {
    _movieName.dispose();
    _movieCategories.dispose();
    _moviePoster.dispose();
    _movieRating.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a movie'),
        elevation: 10.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 8.0,
                ),
                TypeAheadField<TMDBSingleResult>(
                  controller: _movieName,
                  suggestionsCallback: (search) async {
                    if (search.isEmpty) {
                      return [];
                    } else {
                      setState(() {
                        _listMovies.clear();
                      });
                      await searchQuery(query: search);
                      return _listMovies;
                    }
                  },
                  builder: (context, controller, focusNode) {
                    return TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Movie name (year)',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => _movieName.clear(),
                          icon: const Icon(Icons.cancel_rounded),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a movie name with year';
                        }
                        return null;
                      },
                    );
                  },
                  itemBuilder: (context, movie) {
                    return ListTile(
                      title: Text(movie.name ?? movie.title!),
                      subtitle: Text(
                        "${movie.mediaType!} - ${movie.mediaType == 'tv' ? movie.firstAirDate : movie.releaseDate}",
                      ),
                    );
                  },
                  onSelected: (result) {
                    setSelected(result);
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _movieCategories,
                  decoration: InputDecoration(
                    hintText: 'Categories (comma separated)',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add movie categories';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _moviePoster,
                  decoration: InputDecoration(
                    hintText: 'Poster link',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                if (_moviePoster.text.isNotEmpty || _posterPath != '') ...[
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: _posterPath != '' ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150.0,
                        child: _posterPath != '' ? Image.network(_posterPath) : null,
                      ),
                      SizedBox(
                        height: 150.0,
                        child: Image.network(_moviePoster.text),
                      ),
                    ],
                  )
                ],
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _movieRating,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Rating (0-10)',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a rating';
                    }
                    var val = double.tryParse(value)?.toDouble();

                    if (kDebugMode) {
                      print(val);
                    }

                    if (val == null || value.isEmpty) {
                      return 'Please enter a valid rating (0-10)';
                    }

                    if ((val < 0 || val > 10.0)) {
                      return 'Please enter a valid rating (0-10)';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text('Links'),
                const SizedBox(
                  height: 15.0,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: _movieLinks.length,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      TextFormField(
                        key: Key(_movieLinks[index].link.toString()),
                        keyboardType: TextInputType.url,
                        initialValue: _movieLinks[index].link,
                        decoration: InputDecoration(
                          hintText: 'Link',
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: _movieLinks.length > 1
                              ? IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    if (kDebugMode) {
                                      print(_movieLinks);
                                    }
                                    removeLink(index, context);

                                    if (kDebugMode) {
                                      print('Delete $index');
                                      print(_movieLinks);
                                    }
                                  },
                                )
                              : null,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a movie link';
                          }
                          if (Uri.parse(value).isAbsolute == false) {
                            return 'Please enter a valid movie link';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _movieLinks[index] = _movieLinks[index].copyWith(link: value!);
                        },
                        onSaved: (value) {
                          _movieLinks[index] = _movieLinks[index].copyWith(link: value!);
                          if (kDebugMode) {
                            print(value);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      )
                    ]);
                  },
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _movieLinks.add(const MovieLinkModel(link: ''));
                    });
                  },
                  child: const Text('Add new link'),
                ),
                Text(_isSubmitting.toString()),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      // backgroundColor: Colors.teal[400],
                    ),
                    onPressed: _isSubmitting
                        ? null
                        : () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );
                              handleSubmit(context);
                            }
                          },
                    child: Text(widget.movieId == null
                        ? _isSubmitting
                            ? 'Creating...'
                            : 'Create'
                        : _isSubmitting
                            ? 'Updating...'
                            : 'Update'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
