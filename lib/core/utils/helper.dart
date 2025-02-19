import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String convertMinutesToHoursAndMinutes(int totalMinutes) {
  int hours = totalMinutes ~/ 60;
  int minutes = totalMinutes % 60;
  return '${hours}h ${minutes}m';
}

class ScrollHelper {
  late ScrollController scrollController;
  final Function onLoadMore;

  ScrollHelper({required this.onLoadMore}) {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      onLoadMore();
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
