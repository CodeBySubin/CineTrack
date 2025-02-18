class APIConfig {
  static const String baseURL = "https://api.themoviedb.org/3/";
  static const String imageURL = "https://image.tmdb.org/t/p/original/";
  static const String youtube = "https://www.youtube.com/watch?v=";
}

class APIEndPoints {
  static const String movie = 'discover/movie';
  static String cast(int movieId) {
    return "movie/$movieId/credits";
  }

  static String details(int movieId) {
    return "movie/$movieId";
  }

  static String search(String query) {
    return "search/movie?query=$query";
  }

  static String video(int movieId) {
    return "movie/$movieId/videos";
  }
}
