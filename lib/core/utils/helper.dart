// lib/
// ├── core/                                # Core utilities and services
// │   ├── error/                          # Error handling
// │   │   ├── exceptions.dart             # Custom exceptions
// │   │   ├── failure.dart                # Failure models for error propagation
// │   ├── network/                        # Network-related files
// │   │   ├── api_client.dart             # API client setup
// │   │   ├── network_info.dart           # Check for network connectivity
// │   ├── utils/                          # Helper functions and constants
// │   │   ├── constants.dart              # App constants
// │   │   ├── date_helper.dart            # Date helper functions
// │   │   ├── logger.dart                 # Custom logger utility
// ├── data/                               # Data layer (API, database, repositories)
// │   ├── models/                         # Data models (Entities)
// │   │   ├── movie_model.dart            # Movie model class
// │   │   ├── genre_model.dart            # Genre model class
// │   │   ├── spoken_language_model.dart  # SpokenLanguage model class
// │   ├── repositories/                   # Repositories for managing data from sources (API, DB, etc.)
// │   │   ├── movie_repository.dart       # Movie repository class
// │   ├── datasources/                    # API and Local database (SQFlite, etc.)
// │   │   ├── remote_movie_datasource.dart # Remote data source (API calls)
// │   │   ├── local_movie_datasource.dart  # Local data source (SQLite)
// ├── domain/                             # Domain layer (Business logic, Use cases)
// │   ├── entities/                       # Entities for domain layer
// │   │   ├── movie.dart                  # Movie entity
// │   ├── usecases/                       # Use case classes (business logic)
// │   │   ├── get_movies.dart             # Use case for getting movies
// │   ├── repositories/                   # Repository interfaces for dependency inversion
// │   │   ├── movie_repository.dart       # Movie repository interface
// ├── presentation/                       # Presentation layer (UI, ViewModels, Screens)
// │   ├── viewmodels/                     # ViewModels for managing UI logic
// │   │   ├── movie_list_viewmodel.dart   # ViewModel for movie list screen
// │   │   ├── movie_details_viewmodel.dart # ViewModel for movie details screen
// │   ├── screens/                        # Screens/Pages
// │   │   ├── movie_list_screen.dart      # Movie list screen
// │   │   ├── movie_details_screen.dart   # Movie details screen
// │   ├── widgets/                        # Reusable widgets
// │   │   ├── movie_tile.dart             # Movie tile widget
// │   │   ├── loading_indicator.dart      # Loading indicator widget
// │   ├── themes/                         # App themes, styles
// │   │   ├── app_theme.dart              # App-wide theme configuration
// ├── injected/                           # Dependency injection (optional, for providers, etc.)
// │   ├── service_locator.dart            # Dependency injection setup
// ├── main.dart                           # Main entry point for the application

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String convertMinutesToHoursAndMinutes(int totalMinutes) {
  int hours = totalMinutes ~/ 60; // Divide by 60 to get hours
  int minutes = totalMinutes % 60; // Get the remainder for minutes

  // Return the formatted string
  return '${hours}h ${minutes}m';
}

class ScrollHelper {
  late ScrollController scrollController;
  final Function onLoadMore; // Callback function

  ScrollHelper({required this.onLoadMore}) {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      onLoadMore(); // Call the provided function when near the bottom
    }
  }

  void dispose() {
    scrollController.dispose();
  }
}

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }