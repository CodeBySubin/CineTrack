import 'package:moviehub/core/local/local_data.dart';
import 'package:moviehub/data/models/details_model.dart';

class FavouriteRepository {
  final LocalDatabaseDataSource localDataSource;

  // Constructor to initialize the local data source
  FavouriteRepository(this.localDataSource);

  // Initialize the local data source
  Future<void> init() async {
    await localDataSource.init();
  }

  // Fetch all movies
  Future<List<DetailsModel>> getMovies() async {
    return await localDataSource.getMovies();
  }

  // Insert a movie
  Future<void> insertMovie(DetailsModel movie) async {
    await localDataSource.insertMovie(movie);
  }

  // Delete a movie
  Future<void> deleteMovie(int id) async {
    await localDataSource.deleteMovie(id);
  }
  
}
