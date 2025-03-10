import 'package:flutter/material.dart';
import 'package:moviehub/core/utils/colors.dart';
import 'package:moviehub/core/utils/string_constants.dart';

class NoResultWidget extends StatelessWidget {
  final String message;
  final TextStyle? textStyle;

  const NoResultWidget({
    super.key,
    this.message = StringConstants.noResult,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: textStyle ??
            Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Appcolors.white,
                ),
      ),
    );
  }
}
