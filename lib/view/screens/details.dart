import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviehub/core/network/api_endpoint.dart';
import 'package:moviehub/core/utils/helper.dart';
import 'package:moviehub/models/cast_model.dart';
import 'package:moviehub/view/widgets/base_state_widget.dart';
import 'package:moviehub/view/widgets/error_widget.dart';
import 'package:moviehub/view/widgets/gradient_button.dart';
import 'package:moviehub/view/widgets/loader_widget.dart';
import 'package:moviehub/view_models/detail_view_model.dart';
import 'package:moviehub/view_models/favourites_view_model.dart';
import 'package:moviehub/core/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Details extends StatefulWidget {
  final int id;
  const Details({
    super.key,
    required this.id,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final detailViewModel =
          Provider.of<DetailViewModel>(context, listen: false);
      detailViewModel.fetchCast(widget.id);
      detailViewModel.fetchDetails(widget.id);
      detailViewModel.fetchLink(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Consumer<DetailViewModel>(builder: (context, viewModel, child) {
          return BaseStateWidget(
              isLoading: viewModel.isLoading,
              errorMessage: viewModel.errorMessage,
              content: () => SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: APIConfig.imageURL +
                                  viewModel.detailsModel!.backdropPath,
                              imageBuilder: (context, image) => Container(
                                height: 400,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover, image: image),
                                ),
                              ),
                              errorWidget: (context, url, error) => SizedBox(
                                height: 400,
                                child: Center(
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => SizedBox(
                                height: 400,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 50,
                              left: 10,
                              right: 10,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_back,
                                          color: Appcolors.white,
                                        ),
                                        Text(
                                          "Back",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Appcolors.white,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Consumer<FavouriteViewModel>(
                                      builder: (context, favviewModel, child) {
                                    bool data = favviewModel
                                        .isFavorite(viewModel.detailsModel!.id);
                                    return GestureDetector(
                                        onTap: () async {
                                          data
                                              ? favviewModel.removeMovie(
                                                  viewModel.detailsModel!.id)
                                              : await Provider.of<
                                                          FavouriteViewModel>(
                                                      context,
                                                      listen: false)
                                                  .addMovie(
                                                      viewModel.detailsModel!);
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                              Colors.black.withAlpha(128),
                                          child: Icon(
                                            data
                                                ? Icons.favorite
                                                : Icons.favorite_outline,
                                            color: data
                                                ? Colors.red
                                                : Appcolors.white,
                                          ),
                                        ));
                                  }),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 80,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.transparent, Colors.black],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Text(
                                        viewModel.detailsModel!.originalTitle,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Appcolors.white,
                                            ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat('d/MM/yyyy').format(
                                              viewModel
                                                  .detailsModel!.releaseDate),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Appcolors.textgrey),
                                        ),
                                        Icon(Icons.schedule,
                                            color: Appcolors.textgrey),
                                        Text(
                                          convertMinutesToHoursAndMinutes(
                                              viewModel.detailsModel!.runtime),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Appcolors.textgrey,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 20,
                            children: [
                              Text(
                                viewModel.detailsModel!.overview,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Appcolors.textgrey,
                                    ),
                                textAlign: TextAlign.justify,
                              ),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: viewModel.detailsModel!.genres
                                    .map(
                                      (item) => IntrinsicWidth(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Color(0xff303243),
                                          ),
                                          child: Center(
                                            child: Text(
                                              item.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Appcolors.white,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              viewModel.linkModel!.key.isNotEmpty
                                  ? GradientButton(
                                      text: 'Watch Trailer',
                                      onPressed: () {
                                        Uri url = Uri.parse(APIConfig.youtube +
                                            viewModel.linkModel!.key);

                                        launchInBrowser(url);
                                      },
                                    )
                                  : Container(),
                              Text(
                                "Main Cast",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Appcolors.white,
                                    ),
                                textAlign: TextAlign.justify,
                              ),
                              cast(viewModel.cast),
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
        }));
  }
}

Widget cast(List<Cast> cast) {
  return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cast.length,
        itemBuilder: (context, i) {
          return Column(
            spacing: 5,
            children: [
              CachedNetworkImage(
                imageUrl: APIConfig.imageURL + cast[i].profilePath,
                imageBuilder: (context, image) => CircleAvatar(
                  backgroundImage: image,
                  radius: 40,
                ),
                placeholder: (context, url) => Center(
                    child: CircleAvatar(
                        radius: 40, child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => Center(
                    child: CircleAvatar(
                        radius: 40, child: const Icon(Icons.error))),
              ),
              Text(cast[i].name,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Appcolors.white,
                      )),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            width: 20,
          );
        },
      ));
}
