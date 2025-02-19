import 'package:flutter/material.dart';
import 'package:moviehub/core/utils/colors.dart';
import 'package:moviehub/core/utils/string_constants.dart';
import 'package:moviehub/view/screens/favourites.dart';
import 'package:moviehub/view/screens/home.dart';
import 'package:moviehub/view/screens/search.dart';
import 'package:moviehub/view/widgets/drawer.dart';
import 'package:moviehub/view_models/home_viewmodel.dart';
import 'package:moviehub/view_models/search_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> widgets = [Home(), Search(), Favourites()];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Appcolors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          centerTitle: true,
          title: Text(StringConstants.appname,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Appcolors.white,
                  )),
          backgroundColor: Appcolors.primaryColor,
        ),
        drawer: DrawerWidget(),
        backgroundColor: Colors.transparent,
        body: Consumer<UserViewModel>(builder: (context, viewModel, child) {
          return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Appcolors.primaryColor, Appcolors.secondaryColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: widgets[viewModel.selectedIndex]);
        }),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Appcolors.secondaryColor,
            iconSize: 22.0,
            selectedIconTheme: IconThemeData(size: 28.0),
            currentIndex: viewModel.selectedIndex,
            selectedItemColor: Appcolors.primaryColor,
            unselectedItemColor: Colors.white70,
            selectedFontSize: 14.0,
            unselectedFontSize: 12,
            onTap: (index) {
              if (index == 1) {
                Provider.of<SearchViewModel>(context, listen: false).clear();
              }
              viewModel.changeIndex(index);
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: StringConstants.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: StringConstants.search,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                label: StringConstants.favourites,
              ),
            ],
          ),
        ),
      );
    });
  }
}
