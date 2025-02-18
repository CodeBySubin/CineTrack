import 'package:flutter/material.dart';
import 'package:moviehub/core/utils/helper.dart';
import 'package:moviehub/view/widgets/base_state_widget.dart';
import 'package:moviehub/view/widgets/error_widget.dart';
import 'package:moviehub/view/widgets/loader_widget.dart';
import 'package:moviehub/view/widgets/movie_widget.dart';
import 'package:moviehub/view_models/home_viewmodel.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollHelper scrollHelper;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserViewModel>(context, listen: false).fetchHome();
    });

    scrollHelper = ScrollHelper(onLoadMore: () {
      Provider.of<UserViewModel>(context, listen: false).fetchHome();
    });
  }

  @override
  void dispose() {
    scrollHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, viewModel, child) {
        return BaseStateWidget(
            isLoading: viewModel.isLoading,
            errorMessage: viewModel.errorMessage,
            content: () => SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Expanded(
                            child: movies(
                                viewModel.home, scrollHelper.scrollController)),
                        if (viewModel.isFetchingMore)
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      ],
                    ),
                  ),
                ));
      },
    );
  }
}
