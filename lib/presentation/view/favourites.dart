import 'package:flutter/material.dart';
import 'package:moviehub/data/models/details_model.dart';
import 'package:moviehub/presentation/view/details.dart';
import 'package:moviehub/presentation/widgets/network_image_widget.dart';
import 'package:moviehub/view_models/favourites_view_model.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavouriteViewModel>(context, listen: false).loadMovies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: movies(viewModel.movies),
          ));
    });
  }
}

Widget movies(List<DetailsModel> movieList) {
  return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: movieList.length,
      itemBuilder: (context, i) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Details(
                            id: movieList[i].id,
                          )));
            },
            child: networkImageWidget(
              'https://image.tmdb.org/t/p/w500/${movieList[i].posterPath}',
            ));
      });
}
