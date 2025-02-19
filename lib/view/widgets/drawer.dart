import 'package:flutter/material.dart';
import 'package:moviehub/core/utils/colors.dart';
import 'package:moviehub/core/utils/string_constants.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Appcolors.secondaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                StringConstants.appname,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Appcolors.white,
                ),
              ),
            ),
          ),
          _buildDrawerItem(Icons.movie, StringConstants.movies),
          _buildDrawerItem(Icons.settings, StringConstants.settings),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Made with",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Appcolors.white,
                    ),
                  ),
                  Icon(Icons.favorite, color: Appcolors.red, size: 16),
                  const Text(
                    "using Flutter",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Appcolors.white,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const FlutterLogo(size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Appcolors.white),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Appcolors.white,
        ),
      ),
    );
  }
}
