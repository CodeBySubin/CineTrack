import 'package:flutter/material.dart';
import 'package:moviehub/core/utils/image_constants.dart';
import 'package:moviehub/presentation/widgets/movie_widget.dart';
import 'package:moviehub/view_models/search_view_model.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 30,
              children: [
                TextFormField(
                  showCursor: true,
                  cursorColor: Colors.amber,
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  controller: viewModel.searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal:
                            20), // Adjust vertical and horizontal padding
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.black12,
                    filled: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(
                          8.0), // Adjust padding to center the icon
                      child: Image.asset(
                        Appicons.search,
                        color: const Color.fromARGB(255, 147, 137, 137),
                      ),
                    ),
                    hintText: "Search",
                    hintStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 147, 137, 137),
                            ),
                  ),
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    viewModel.search();
                  },
                ),
                Expanded(child: movies(viewModel.searchList)),
              ],
            ),
          ));
    });
  }
}
