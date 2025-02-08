import 'package:dio/dio.dart';

class DioExceptionHandler {
  static String handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timed out. Please check your internet.";
      case DioExceptionType.sendTimeout:
        return "Request timed out. Try again later.";
      case DioExceptionType.receiveTimeout:
        return "Server took too long to respond.";
      case DioExceptionType.badResponse:
        return handleBadResponse(error);
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.connectionError:
        return "No internet connection.";
      case DioExceptionType.unknown:
      default:
        return "Something went wrong. Please try again.";
    }
  }

  static String handleBadResponse(DioException error) {
    if (error.response == null) return "Unknown error occurred.";
    switch (error.response?.statusCode) {
      case 400:
        return "Bad request. Please try again.";
      case 401:
        return "Unauthorized. Please log in again.";
      case 403:
        return "Access denied. You don't have permission.";
      case 404:
        return "Resource not found.";
      case 500:
      default:
        return "Server error. Please try again later.";
    }
  }
}
