import 'package:flutter/material.dart';
import 'package:moviehub/core/network/dio_exception.dart';
import 'package:moviehub/core/utils/colors.dart';

class CustomErrorWidget extends StatelessWidget {
  final Errors error;
  const CustomErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff8000FF), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              error.statusCode!,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Appcolors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              error.message,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Appcolors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
