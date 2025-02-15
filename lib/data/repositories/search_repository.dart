import 'package:flutter/material.dart';
import 'package:moviehub/core/network/api_client.dart';
import 'package:moviehub/core/network/api_endpoint.dart';
import 'package:moviehub/data/models/home_model.dart';

class SearchRepository {
  final ApiClient apiClient;
  SearchRepository(this.apiClient);

  Future<List<Result>> getSearch(
      TextEditingController keyword, int page) async {
    final response = await apiClient
        .get(APIEndPoints.search(keyword.text), params: {"page": page});
    final List<dynamic>? resultsJson = response.data['results'];
    return resultsJson?.map((json) => Result.fromJson(json)).toList() ?? [];
  }
}
