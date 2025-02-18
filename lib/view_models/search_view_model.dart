import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:moviehub/core/network/api_endpoint.dart';
import 'package:moviehub/core/network/dio_exception.dart';
import 'package:moviehub/models/home_model.dart';
import 'package:moviehub/view_models/base_view_model.dart';

class SearchViewModel extends BaseViewModel {
  int currentPage = 1;
  bool isFetchingMore = false;
  Errors? errorMessage;
  TextEditingController searchController = TextEditingController();
  List<Result> searchList = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> search() async {
    if (isFetchingMore || searchController.text.trim().isEmpty) return;
    isFetchingMore = true;
    notifyListeners();
    try {
      if (currentPage == 1) searchList.clear();
      final response = await apiClient.get(
          APIEndPoints.search(searchController.text),
          params: {"page": currentPage});
      final List<dynamic>? resultsJson = response.data['results'];
      List<Result> searchResults =
          resultsJson?.map((json) => Result.fromJson(json)).toList() ?? [];
      searchList.addAll(searchResults);
      currentPage++;
      errorMessage = null;
    } on DioException catch (e) {
      errorMessage = DioExceptionHandler.handleDioError(e);
    } finally {
      isFetchingMore = false;
      notifyListeners();
    }
  }
}
