import 'package:flutter/material.dart';
import 'package:moviehub/presentation/widgets/movie_widget.dart';
import 'package:moviehub/view_models/user_viewmodel.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: movies(viewModel.users)),
              ],
            ),
          ),
        );
      }
    });
  }
}


