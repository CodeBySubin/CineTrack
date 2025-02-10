import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget networkImageWidget(String url) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, image) => Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white),
        image: DecorationImage(fit: BoxFit.cover, image: image),
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 176, 166, 169),
      ),
    ),
    placeholder: (context, url) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 176, 166, 169),
        ),
        child: Center(child: const CircularProgressIndicator())),
    errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 176, 166, 169),
        ),
        child: Center(child: const Icon(Icons.error))),
  );
}
