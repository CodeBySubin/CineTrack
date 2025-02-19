import 'package:dio/dio.dart';
import 'package:moviehub/core/network/api_endpoint.dart';
import 'package:moviehub/core/network/dio_exception.dart';
import 'package:moviehub/models/cast_model.dart';
import 'package:moviehub/models/details_model.dart';
import 'package:moviehub/models/link_model.dart';
import 'package:moviehub/view_models/base_view_model.dart';

class DetailViewModel extends BaseViewModel {
  Errors? errorMessage;
  List<Cast> cast = [];
  List<LinkModel> videos = [];
  DetailsModel? detailsModel;

  Future<void> fetchDetails(int movieID) async {
    setLoading(true);
    try {
      final response = await apiClient.get(APIEndPoints.details(movieID));
      detailsModel = DetailsModel.fromJson(response.data);
    } on DioException catch (e) {
      errorMessage = DioExceptionHandler.handleDioError(e);
    } finally {
      setLoading(false);
    }
  }

  Future<void> fetchLink(int movieID) async {
    setLoading(true);
    try {
      final response = await apiClient.get(APIEndPoints.video(movieID));
      final List<dynamic> resultsJson = response.data['results'];
      videos = resultsJson.map((json) => LinkModel.fromJson(json)).toList();
    } on DioException catch (e) {
      errorMessage = DioExceptionHandler.handleDioError(e);
    } finally {
      setLoading(false);
    }
  }

  Future<void> fetchCast(int movieID) async {
    setLoading(true);
    try {
      final response = await apiClient.get(APIEndPoints.cast(movieID));
      final List<dynamic> resultsJson = response.data['cast'];
      cast = resultsJson.map((json) => Cast.fromJson(json)).toList();
    } on DioException catch (e) {
      errorMessage = DioExceptionHandler.handleDioError(e);
    } finally {
      setLoading(false);
    }
  }
}
