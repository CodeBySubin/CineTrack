import 'package:flutter/material.dart';
import 'package:moviehub/core/utils/colors.dart';
import 'package:moviehub/core/utils/helper.dart';
import 'package:moviehub/core/utils/image_constants.dart';
import 'package:moviehub/core/utils/string_constants.dart';
import 'package:moviehub/view/widgets/base_state_widget.dart';
import 'package:moviehub/view/widgets/error_widget.dart';
import 'package:moviehub/view/widgets/loader_widget.dart';
import 'package:moviehub/view/widgets/movie_widget.dart';
import 'package:moviehub/view/widgets/no_result_widget.dart';
import 'package:moviehub/view_models/search_view_model.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late ScrollHelper scrollHelper;

  @override
  void initState() {
    super.initState();
    scrollHelper = ScrollHelper(onLoadMore: () {
      Provider.of<SearchViewModel>(context, listen: false).search();
    });
  }

  @override
  void dispose() {
    scrollHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(builder: (context, viewModel, child) {
      return BaseStateWidget(
          isLoading: viewModel.isLoading,
          errorMessage: viewModel.errorMessage,
          content: () => Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 30,
                  children: [
                    TextFormField(
                      showCursor: true,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      controller: viewModel.searchController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.black12,
                        filled: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            Appicons.search,
                            color: const Color.fromARGB(255, 147, 137, 137),
                          ),
                        ),
                        hintText: "Search",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 147, 137, 137),
                            ),
                      ),
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        viewModel.currentPage = 1;
                        viewModel.searchList = [];
                        viewModel.search();
                      },
                    ),
                    Expanded(
                        child: viewModel.searchList.isEmpty
                            ? NoResultWidget(
                                message: StringConstants.findYourMovie)
                            : movies(viewModel.searchList,
                                scrollHelper.scrollController)),
                    if (viewModel.isFetchingMore)
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: loaderWidget(),
                      ),
                  ],
                ),
              )));
    });
  }
}
