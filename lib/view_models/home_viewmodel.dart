import 'package:dio/dio.dart';
import 'package:moviehub/core/network/api_endpoint.dart';
import 'package:moviehub/core/network/dio_exception.dart';
import 'package:moviehub/models/cast_model.dart';
import 'package:moviehub/models/details_model.dart';
import 'package:moviehub/models/link_model.dart';
import 'package:moviehub/view_models/base_view_model.dart';
import '../models/home_model.dart';

class UserViewModel extends BaseViewModel {
  int _selectedIndex = 0;
  int _buttonindex = 0;
  int currentPage = 1;
  bool isFetchingMore = false;
  Errors? errorMessage;
  int get selectedIndex => _selectedIndex;
  int get buttonIndex => _buttonindex;

  List<Result> home = [];
  DetailsModel? detailsModel;
  LinkModel? linkModel;

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void changeButton(int index) {
    _buttonindex = index;
    notifyListeners();
  }



  Future<void> fetchHome() async {
    if (isFetchingMore) return;
    isFetchingMore = true;
    notifyListeners();
    try {
      if (currentPage == 1) home.clear();
      final response = await apiClient
          .get(APIEndPoints.movie, params: {"page": currentPage});
      final List<dynamic>? resultsJson = response.data['results'];
      List<Result> searchResults =
          resultsJson?.map((json) => Result.fromJson(json)).toList() ?? [];
      home.addAll(searchResults);
      currentPage++;
      errorMessage = null;
    } on DioException catch (e) {
      errorMessage = DioExceptionHandler.handleDioError(e);
    } finally {
      setLoading(false);
      isFetchingMore = false;
      notifyListeners();
    }
  }




}
