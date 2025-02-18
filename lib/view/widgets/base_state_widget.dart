import 'package:flutter/material.dart';
import 'package:moviehub/core/network/dio_exception.dart';

class BaseStateWidget extends StatelessWidget {
  final bool isLoading;
  final Errors? errorMessage;
  final Widget Function() content;
  final Widget Function()? loader;
  final Widget Function(Errors)? errorWidget;

  const BaseStateWidget({
    super.key,
    required this.isLoading,
    required this.errorMessage,
    required this.content,
    this.loader,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loader != null
          ? loader!()
          : const Center(child: CircularProgressIndicator());
    }
    if (errorMessage != null) {
      return errorWidget != null
          ? errorWidget!(errorMessage!)
          : Center(
              child: Text(
                errorMessage!.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
    }
    return content();
  }
}
