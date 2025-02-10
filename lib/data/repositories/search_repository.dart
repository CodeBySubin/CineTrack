import 'package:flutter/material.dart';
import 'package:moviehub/core/network/api_client.dart';
import 'package:moviehub/core/network/api_endpoint.dart';
import 'package:moviehub/data/models/home_model.dart';

class SearchRepository {
  final ApiClient apiClient;
  SearchRepository(this.apiClient);

  Future<List<Result>> getsearch(TextEditingController keyword) async {
    final response = await apiClient.get(APIEndPoints.search(keyword.text));
    print(keyword);
    print(response);
    final List<dynamic> resultsJson = response.data['results'];
    return resultsJson.map((json) => Result.fromJson(json)).toList();
  }
}
