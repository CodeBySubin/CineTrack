import 'package:flutter/material.dart';
import 'package:moviehub/data/models/details_model.dart';
import 'package:moviehub/data/repositories/favourite_respository.dart';

class FavouriteViewModel extends ChangeNotifier {
  final FavouriteRepository favouriteRepository;

  List<DetailsModel> _movies = [];

  FavouriteViewModel(this.favouriteRepository);

  List<DetailsModel> get movies => _movies;

  // Initialize repository
  Future<void> init() async {
    await favouriteRepository.init();
    await loadMovies();
  }

  // Load all movies
  Future<void> loadMovies() async {
    _movies = await favouriteRepository.getMovies();
    notifyListeners();  // Notify the UI to rebuild
  }

  // Add a movie
  Future<void> addMovie(DetailsModel movie) async {
    await favouriteRepository.insertMovie(movie);
    await loadMovies();
  }

  // Delete a movie
  Future<void> removeMovie(int id) async {
    await favouriteRepository.deleteMovie(id);
    await loadMovies();
  }
    bool isFavorite(int id) {
    return _movies.any((movie) => movie.id == id);
  }
}
