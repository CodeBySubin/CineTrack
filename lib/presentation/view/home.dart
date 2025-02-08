import 'package:flutter/material.dart';
import 'package:moviehub/data/models/home_model.dart';
import 'package:moviehub/presentation/view/details.dart';
import 'package:moviehub/core/utils/colors.dart';
import 'package:moviehub/core/utils/image_constants.dart';
import 'package:moviehub/presentation/view/favourites.dart';
import 'package:moviehub/presentation/view/search.dart';
import 'package:moviehub/view_models/user_viewmodel.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> widgets = [Homedata(), Search(), Favourites()];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Consumer<UserViewModel>(builder: (context, viewModel, child) {
          return widgets[viewModel.selectedIndex];
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

class Homedata extends StatefulWidget {
  const Homedata({super.key});

  @override
  State<Homedata> createState() => _HomedataState();
}

class _HomedataState extends State<Homedata> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserViewModel>(context, listen: false).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, viewModel, child) {
      if (viewModel.users.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else {
        return SingleChildScrollView(
            child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff8000FF), Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 280,
                    child: Text("What do you want to watch today?",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Appcolors.white,
                            )),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                        fillColor: Colors.black12,
                        filled: true,
                        hintText: "Search",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 147, 137, 137),
                            ),
                        suffixIcon: Image.asset(Appicons.search)),
                  ),
                  scrollbuton(viewModel.buttons),
                  Text("Most popular",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Appcolors.white,
                          )),
                  movies(viewModel.users),
                  movies(viewModel.users),
                ],
              ),
            ),
          ),
        ));
      }
    });
  }
}

Widget scrollbuton(List<String> types) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: SizedBox(
      height: 39,
      child: Consumer<UserViewModel>(builder: (context, viewModel, child) {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: types.length,
            itemBuilder: (context, i) {
              bool isSelected = i == viewModel.buttonIndex;
              return GestureDetector(
                onTap: () {
                  viewModel.changeButton(i);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isSelected ? Colors.pink : Colors.transparent,
                  ),
                  margin: EdgeInsets.only(right: 15),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Center(
                      child: Text(types[i],
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Appcolors.white,
                                  )),
                    ),
                  ),
                ),
              );
            });
      }),
    ),
  );
}

Widget movies(List<Result> movieList) {
  return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: 5,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Details()));
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${movieList[i].posterPath}')),
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 176, 166, 169),
            ),
          ),
        );
      });
}

