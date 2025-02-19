import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:moviehub/core/utils/colors.dart';

Widget networkImageWidget(String url) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, image) => Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Appcolors.white),
        image: DecorationImage(fit: BoxFit.cover, image: image),
        borderRadius: BorderRadius.circular(10),
        color: Appcolors.textgrey,
      ),
    ),
    placeholder: (context, url) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Appcolors.white),
          borderRadius: BorderRadius.circular(10),
          color: Appcolors.textgrey,
        ),
        child: Center(child: const CircularProgressIndicator())),
    errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Appcolors.white),
          borderRadius: BorderRadius.circular(10),
          color: Appcolors.textgrey,
        ),
        child: Center(child: const Icon(Icons.error))),
  );
}
