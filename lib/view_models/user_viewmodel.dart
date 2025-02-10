import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moviehub/core/network/dio_exception.dart';
import 'package:moviehub/data/models/cast_model.dart';
import 'package:moviehub/data/models/details_model.dart';
import '../data/models/home_model.dart';
import '../data/repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  int _selectedIndex = 0;
  int _buttonindex = 0;
  bool isLoading = true;

  int get selectedIndex => _selectedIndex;
  int get buttonIndex => _buttonindex;

  List<Result> users = [];
  List<Cast> cast = [];
  DetailsModel? detailsModel;
  List<String> buttons = [
    "Action",
    "Comedy",
    "Drama",
    "Romance",
    "Horror",
    "Sci-Fi",
    "Fantasy",
    "Thriller",
    "Mystery",
    "Documentary",
    "Animation"
  ];

  UserViewModel(this.userRepository);

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void changeButton(int index) {
    _buttonindex = index;
    notifyListeners();
  }

  Future<void> fetchUsers() async {
    try {
      users = await userRepository.getUser();
    } on DioException catch (e) {
      DioExceptionHandler.handleDioError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCast(int movieID) async {
    isLoading = true;
    notifyListeners();
    try {
      cast = await userRepository.getCast(movieID);
    } on DioException catch (e) {
      DioExceptionHandler.handleDioError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDetails(int movieID) async {
    isLoading = true;
    notifyListeners();
    try {
      detailsModel = await userRepository.getDetails(movieID);
    } on DioException catch (e) {
      DioExceptionHandler.handleDioError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
