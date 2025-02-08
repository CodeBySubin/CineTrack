

class APIConfig{
static const String baseURL = "https://api.themoviedb.org/3/";
static const String imageURL ="https://image.tmdb.org/t/p/original/";
}

class APIEndPoints{
  static const String movie ='movie/popular';
static String cast(int movieId){
  return 'movie/$movieId/credits';
}
static String details(int movieId){
  return "movie/$movieId";

}
}