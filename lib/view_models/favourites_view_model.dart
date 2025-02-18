import 'package:flutter/material.dart';
import 'package:moviehub/core/local/local_data.dart';
import 'package:moviehub/models/details_model.dart';

class FavouriteViewModel extends ChangeNotifier {
  final LocalDatabaseDataSource localDataSource;

  List<DetailsModel> _movies = [];

  FavouriteViewModel(this.localDataSource){
    loadMovies();
  }

  List<DetailsModel> get movies => _movies;

  // Initialize repository
  Future<void> init() async {
    await loadMovies();
  }

  Future<void> loadMovies() async {
    _movies =  await localDataSource.getMovies();
    notifyListeners(); 
  }

  // Add a movie
  Future<void> addMovie(DetailsModel movie) async {
    await localDataSource.insertMovie(movie);
    await loadMovies();
  }

  // Delete a movie
  Future<void> removeMovie(int id) async {
    await localDataSource.deleteMovie(id);
    await loadMovies();
  }
    bool isFavorite(int id) {
    return _movies.any((movie) => movie.id == id);
  }
}


