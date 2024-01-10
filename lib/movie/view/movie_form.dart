import 'package:anu3/group/group.dart';
import 'package:anu3/group/providers/group_list_notifier_provider.dart';
import 'package:anu3/movie/api/movie_repository.dart';
import 'package:anu3/movie/model/movie_link_model.dart';
import 'package:anu3/movie/model/movie_model.dart';
import 'package:anu3/movie/provider/movie_list_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    }
  }

  Future<void> _addLinks(int movieId) async {
    List<MovieLinkModel> links = await ref.read(movieRepositoryProvider).getLinks(movieId: movieId);
    if (kDebugMode) {
      print(links.map((e) => e.link).toList());
    }
    setState(() {
      _movieLinks.addAll(links.map((e) => e.link).toList());
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
  var _movieLinks = <String>[""];
  bool _isSubmitting = false;

  handleSubmit(BuildContext context) {
    setState(() {
      _isSubmitting = true;
    });

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
          )
          .then(
        (value) {
          if (kDebugMode) {
            print(value);
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
                TextFormField(
                  controller: _movieName,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Movie name (year)',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a movie name with year';
                    }
                    return null;
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
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _movieRating,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Rating',
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
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text('Movie links'),
                const SizedBox(
                  height: 15.0,
                ),
                ...List.generate(_movieLinks.length, (index) {
                  return Column(children: [
                    TextFormField(
                      keyboardType: TextInputType.url,
                      initialValue: _movieLinks[index],
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
                                  setState(() {
                                    _movieLinks.removeAt(index);
                                  });

                                  if (kDebugMode) {
                                    print('Delete');
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
                      onSaved: (value) {
                        setState(() {
                          _movieLinks[index] = value!;
                        });
                        if (kDebugMode) {
                          print(value);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    )
                  ]);
                }),
                const SizedBox(
                  height: 15.0,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _movieLinks.add('');
                    });
                  },
                  child: const Text('Add new link'),
                ),
                const SizedBox(
                  height: 15.0,
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
                              if (kDebugMode) {
                                print(_movieLinks);
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );

                              handleSubmit(context);
                            }
                          },
                    child: Text(widget.movieId == null ? 'Create' : 'Update'),
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
