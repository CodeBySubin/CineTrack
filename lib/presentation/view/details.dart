import 'package:flutter/material.dart';
import 'package:moviehub/core/network/api_endpoint.dart';
import 'package:moviehub/data/models/cast_model.dart';
import 'package:moviehub/presentation/view/home.dart';
import 'package:moviehub/view_models/user_viewmodel.dart';
import 'package:moviehub/presentation/widgets/gradient_button.dart';
import 'package:moviehub/core/utils/colors.dart';
import 'package:moviehub/core/utils/string_constants.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserViewModel>(context, listen: false).fetchCast(939243);
      Provider.of<UserViewModel>(context, listen: false).fetchDetails(939243);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Consumer<UserViewModel>(builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 400,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    APIConfig.imageURL+ viewModel.detailsModel!.posterPath))),
                      ),
                      Positioned(
                          top: 50,
                          left: 10,
                          right: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Row(
                                  spacing: 5,
                                  children: [
                                    Icon(
                                      Icons.arrow_back,
                                      color: Appcolors.white,
                                    ),
                                    Text("Back",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Appcolors.white,
                                            )),
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.black.withAlpha(128),
                                child: Icon(
                                  Icons.favorite_outline,
                                  color: Appcolors.white,
                                ),
                              )
                            ],
                          )),
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
                                Text("${viewModel.detailsModel!.belongsToCollection.name} (2021)",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Appcolors.white,
                                        )),
                                Row(
                                  spacing: 5,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${viewModel.detailsModel!.releaseDate} (BR)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Appcolors.textgrey)),
                                    Icon(Icons.schedule,
                                        color: Appcolors.textgrey),
                                    Text('1h 53m',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Appcolors.textgrey,
                                            )),
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20,
                      children: [
                        Text(
                          "Após cumprir pena por um crime violento, Ruth volta ao convívio na sociedade, que se recusa a perdoar seu passado. Discriminada no lugar que já chamou de lar, sua única esperança é encontrar a irmã, que ela havia sido forçada a deixar para trás.",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Appcolors.textgrey,
                                  ),
                          textAlign: TextAlign.justify,
                        ),
                        GradientButton(
                          text: StringConstants.access,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          },
                        ),
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
                        Text(
                          "Categories",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Appcolors.white,
                              ),
                        ),
                        scrollbuton(),
                        Text(
                          "Recommendations",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Appcolors.white,
                              ),
                        ),
                        // movies()
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        }));
  }
}

Widget cast(List<Cast> cast) {
  return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, i) {
          return Column(
            spacing: 5,
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(APIConfig.imageURL + cast[i].profilePath),
                radius: 40,
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

Widget scrollbuton() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: SizedBox(
      height: 39,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, i) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff303243),
              ),
              margin: EdgeInsets.only(right: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Center(
                  child: Text('Drama',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Appcolors.white,
                          )),
                ),
              ),
            );
          }),
    ),
  );
}
