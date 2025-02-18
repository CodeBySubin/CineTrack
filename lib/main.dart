import 'package:flutter/material.dart';
import 'package:moviehub/core/local/local_data.dart';
import 'package:moviehub/core/network/api_client.dart';
import 'package:moviehub/view/screens/splash.dart';
import 'package:moviehub/view_models/detail_view_model.dart';
import 'package:moviehub/view_models/favourites_view_model.dart';
import 'package:moviehub/view_models/search_view_model.dart';
import 'package:moviehub/view_models/home_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserViewModel(),
        ),
         ChangeNotifierProvider(
          create: (_) => DetailViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchViewModel(),
        ),
        ChangeNotifierProvider(
            create: (context) => FavouriteViewModel(LocalDatabaseDataSource())),
      ],
      child: MaterialApp(
        title: 'Movies App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const Splash(),
      ),
    );
  }
}
