import 'package:flutter/material.dart';
import 'package:moviehub/core/network/api_client.dart';

class BaseViewModel extends ChangeNotifier {
  ApiClient apiClient = ApiClient();

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
