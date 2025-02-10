import 'package:flutter/material.dart';
import 'package:moviehub/core/utils/colors.dart';
import 'package:moviehub/presentation/view/favourites.dart';
import 'package:moviehub/presentation/view/home.dart';
import 'package:moviehub/presentation/view/search.dart';
import 'package:moviehub/view_models/user_viewmodel.dart';
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
          leading: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          centerTitle: true,
          title: Text("MOVIE HUB",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Appcolors.white,
                  )),
          backgroundColor: Color(0xff8000FF),
        ),
        backgroundColor: Colors.transparent,
        body: Consumer<UserViewModel>(builder: (context, viewModel, child) {
          return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff8000FF), Colors.black],
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
            backgroundColor: Colors.black,
            iconSize: 22.0,
            selectedIconTheme: IconThemeData(size: 28.0),
            currentIndex: viewModel.selectedIndex,
            selectedItemColor: Color(0xff8000FF),
            unselectedItemColor: Colors.white70,
            selectedFontSize: 14.0,
            unselectedFontSize: 12,
            onTap: (index) {
              viewModel.changeIndex(index);
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                label: "Favorites",
              ),
            ],
          ),
        ),
      );
    });
  }
}