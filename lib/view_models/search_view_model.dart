import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:moviehub/core/network/dio_exception.dart';
import 'package:moviehub/data/models/home_model.dart';
import 'package:moviehub/data/repositories/search_repository.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchRepository searchRepository;
  bool isLoading = false;
  int currentPage = 1;
  bool isFetchingMore = false;
  String? errorMessage;
  TextEditingController searchController = TextEditingController();
  List<Result> searchList = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  SearchViewModel(this.searchRepository);

  Future<void> search() async {
    if (isFetchingMore || searchController.text.trim().isEmpty) return;

    isFetchingMore = true;
    notifyListeners();

    try {
      if (currentPage == 1) searchList.clear(); // Clear previous search results for new search
      List<Result> searchResults = await searchRepository.getSearch(searchController, currentPage);
      
      searchList.addAll(searchResults);
      currentPage++;
      errorMessage = null; // Reset error message on success
    } on DioException catch (e) {
      errorMessage = DioExceptionHandler.handleDioError(e);
    } finally {
      isFetchingMore = false;
      notifyListeners();
    }
  }
}
