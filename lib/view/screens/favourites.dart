import 'package:flutter/material.dart';
import 'package:moviehub/core/network/api_endpoint.dart';
import 'package:moviehub/core/utils/colors.dart';
import 'package:moviehub/models/details_model.dart';
import 'package:moviehub/view/screens/details.dart';
import 'package:moviehub/view/widgets/network_image_widget.dart';
import 'package:moviehub/view/widgets/no_result_widget.dart';
import 'package:moviehub/view_models/favourites_view_model.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: viewModel.movies.isEmpty
                ? NoResultWidget()
                : movies(viewModel.movies),
          ));
    });
  }
}

Widget movies(List<DetailsModel> movieList) {
  return Consumer<FavouriteViewModel>(builder: (context, viewModel, child) {
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
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: networkImageWidget(
                    APIConfig.imageURL + movieList[i].posterPath!,
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: GestureDetector(
                    onTap: () {
                      viewModel.removeMovie(movieList[i].id);
                    },
                    child: Icon(
                      Icons.delete_outlined,
                      color: Appcolors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  });
}
