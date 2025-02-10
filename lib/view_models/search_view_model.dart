import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:moviehub/core/network/dio_exception.dart';
import 'package:moviehub/data/models/home_model.dart';
import 'package:moviehub/data/repositories/search_repository.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchRepository searchRepository;
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  List<Result> searchList = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  SearchViewModel(this.searchRepository);

  Future<void> search() async {
    try {
      searchList = await searchRepository.getsearch(searchController);
      notifyListeners();
    } on DioException catch (e) {
      DioExceptionHandler.handleDioError(e);
    }
  }
}
