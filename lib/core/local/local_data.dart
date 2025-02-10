import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:moviehub/data/models/details_model.dart';

class LocalDatabaseDataSource {
  static final LocalDatabaseDataSource _instance = LocalDatabaseDataSource._internal();
  factory LocalDatabaseDataSource() => _instance;
  LocalDatabaseDataSource._internal();

  Database? _database;

  Future<void> init() async {
    if (_database != null) return;
    String path = join(await getDatabasesPath(), 'movies_database.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE movies (
            id INTEGER PRIMARY KEY,
            adult INTEGER,
            backdropPath TEXT,
            budget INTEGER,
            genres TEXT,
            imdbId TEXT,
            originCountry TEXT,
            originalLanguage TEXT,
            originalTitle TEXT,
            overview TEXT,
            popularity REAL,
            posterPath TEXT,
            releaseDate TEXT,
            revenue INTEGER,
            runtime INTEGER,
            spokenLanguages TEXT,
            status TEXT,
            tagline TEXT,
            title TEXT,
            video INTEGER,
            voteAverage REAL,
            voteCount INTEGER
          )
        ''');
      },
    );
  }

  // Insert a movie into the database
  Future<void> insertMovie(DetailsModel movie) async {
    await init();
    await _database!.insert(
      'movies',
      movie.toDatabaseJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve all movies from the database
  Future<List<DetailsModel>> getMovies() async {
    await init();
    final List<Map<String, dynamic>> maps = await _database!.query('movies');
    return maps.map((e) => DetailsModel.fromDatabaseJson(e)).toList();
  }

  // Delete a movie by its ID
  Future<void> deleteMovie(int id) async {
    await init();
    await _database!.delete('movies', where: 'id = ?', whereArgs: [id]);
  }
}
