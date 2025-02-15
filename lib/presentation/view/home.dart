import 'package:flutter/material.dart';
import 'package:moviehub/core/utils/helper.dart';
import 'package:moviehub/presentation/widgets/movie_widget.dart';
import 'package:moviehub/view_models/user_viewmodel.dart';
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
      Provider.of<UserViewModel>(context, listen: false).fetchUsers();
    });

    scrollHelper = ScrollHelper(
      onLoadMore: () {
        Provider.of<UserViewModel>(context, listen: false).fetchUsers();
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
        if (viewModel.isLoading && viewModel.users.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.errorMessage != null) {
          return Center(
            child: Text(viewModel.errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16)),
          );
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Expanded(child: movies(viewModel.users, scrollHelper.scrollController)),
                if (viewModel.isFetchingMore)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
