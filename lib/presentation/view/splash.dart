import 'package:flutter/material.dart';
import 'package:moviehub/presentation/view/home.dart';
import 'package:moviehub/presentation/widgets/gradient_button.dart';
import 'package:moviehub/core/utils/colors.dart';
import 'package:moviehub/core/utils/image_constants.dart';
import 'package:moviehub/core/utils/string_constants.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.splashimage,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  Text(StringConstants.appname,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Appcolors.white,
                              fontWeight: FontWeight.bold)),
                  Text(StringConstants.description_one,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Appcolors.white)),
                  Text(StringConstants.description_two,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Appcolors.white)),
                  GradientButton(
                    text: StringConstants.access,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
