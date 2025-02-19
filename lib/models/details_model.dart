import 'dart:convert';

class DetailsModel {
  String? backdropPath;
  List<Genre>? genres;
  int id;
  String? originalTitle;
  String? overview;
  String? posterPath;
  DateTime? releaseDate;
  int? revenue;
  int? runtime;
  String? title;

  DetailsModel({
    required this.id,
    this.backdropPath,
    this.genres,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.title,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      id: json["id"] ?? 0,
      backdropPath: json["backdrop_path"] ?? "",
      genres: json["genres"] != null
          ? List<Genre>.from((json["genres"] as List)
              .map((x) => Genre.fromJson(x))
              .toList())
          : [],
      originalTitle: json["original_title"] ?? "",
      overview: json["overview"] ?? "",
      posterPath: json["poster_path"] ?? "",
      releaseDate: json["release_date"] != null && json["release_date"].isNotEmpty
          ? DateTime.tryParse(json["release_date"])
          : null,
      revenue: json["revenue"] ?? 0,
      runtime: json["runtime"] ?? 0,
      title: json["title"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "backdrop_path": backdropPath ?? "",
        "genres": genres != null ? List<dynamic>.from(genres!.map((x) => x.toJson())) : [],
        "original_title": originalTitle ?? "",
        "overview": overview ?? "",
        "poster_path": posterPath ?? "",
        "release_date": releaseDate != null
            ? "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}"
            : "",
        "revenue": revenue ?? 0,
        "runtime": runtime ?? 0,
        "title": title ?? "",
      };

  // Convert object to map for SQLite insertion
  Map<String, dynamic> toDatabaseJson() {
    return {
      'id': id,
      'backdropPath': backdropPath ?? "",
      'genres': genres != null ? jsonEncode(genres!.map((genre) => genre.toJson()).toList()) : "[]",
      'originalTitle': originalTitle ?? "",
      'overview': overview ?? "",
      'posterPath': posterPath ?? "",
      'releaseDate': releaseDate?.toIso8601String() ?? "",
      'revenue': revenue ?? 0,
      'runtime': runtime ?? 0,
      'title': title ?? "",
    };
  }

  // Convert map from SQLite back to object
  factory DetailsModel.fromDatabaseJson(Map<String, dynamic> json) {
    return DetailsModel(
      id: json['id'] ?? 0,
      backdropPath: json['backdropPath'] ?? "",
      genres: json['genres'] != null
          ? List<Genre>.from(jsonDecode(json['genres']).map((x) => Genre.fromJson(x)))
          : [],
      originalTitle: json['originalTitle'] ?? "",
      overview: json['overview'] ?? "",
      posterPath: json['posterPath'] ?? "",
      releaseDate: json['releaseDate'] != null && json['releaseDate'].isNotEmpty
          ? DateTime.tryParse(json['releaseDate'])
          : null,
      revenue: json['revenue'] ?? 0,
      runtime: json['runtime'] ?? 0,
      title: json['title'] ?? "",
    );
  }
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
