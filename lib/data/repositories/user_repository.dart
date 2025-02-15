import 'package:moviehub/core/network/api_client.dart';
import 'package:moviehub/core/network/api_endpoint.dart';
import 'package:moviehub/data/models/cast_model.dart';
import 'package:moviehub/data/models/details_model.dart';
import 'package:moviehub/data/models/home_model.dart';

class UserRepository {
  final ApiClient apiClient;
  UserRepository(this.apiClient);

  Future<List<Result>> getUser(int page) async {
    final response = await apiClient.get(APIEndPoints.movie);

    final List<dynamic> resultsJson = response.data['results'];
    return resultsJson.map((json) => Result.fromJson(json)).toList();
  }

  Future<List<Cast>> getCast(int movieID) async {
    final response = await apiClient.get(APIEndPoints.cast(movieID));
    final List<dynamic> resultsJson = response.data['cast'];
    return resultsJson.map((json) => Cast.fromJson(json)).toList();
  }

  Future<DetailsModel> getDetails(int movieID) async {
    final response = await apiClient.get(APIEndPoints.details(movieID));
    return DetailsModel.fromJson(response.data);
  }
}
