import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviehub/models/home_model.dart';
import 'package:moviehub/view/screens/details.dart';
import 'package:moviehub/view/widgets/network_image_widget.dart';

Widget movies(List<Result> movieList, ScrollController scrollController) {
  return GridView.builder(
          controller: scrollController, 
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: movieList.length,
      itemBuilder: (context, i) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Details(
                            id: movieList[i].id,
                          )));
            },
            child: networkImageWidget(
                'https://image.tmdb.org/t/p/w500/${movieList[i].posterPath}'));
      });
}
