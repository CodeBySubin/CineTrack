import 'package:flutter/material.dart';
import 'package:moviehub/core/network/api_client.dart';
import 'package:moviehub/data/repositories/user_repository.dart';
import 'package:moviehub/presentation/view/splash.dart';
import 'package:moviehub/view_models/user_viewmodel.dart';
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
          create: (_) => UserViewModel(UserRepository(ApiClient())),
        ),
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


// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<CounterProvider>(context, listen: false).fetchdata();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body:
//         Consumer<CounterProvider>(builder: (context, counterProvider, child) {
//       return counterProvider.isloading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: counterProvider.clothlist.length,
//               itemBuilder: (context, i) {
//                 return Column(
//                   children: [
//                     Image.network(counterProvider.clothlist[i].image),
//                     Text(counterProvider.clothlist[i].name),
//                   ],
//                 );
//               });
//     }));
//   }
// }

// class CounterProvider with ChangeNotifier {
//   Dio dio = Dio();
//   bool isloading = false;
//   List<Cloth> clothlist = [];

//   Future<void> fetchdata() async {
//     isloading = true;
//     try {
//       final respose = await dio.get('https://fakestoreapi.com/products');
//       if (respose.statusCode == 200) {
//         isloading = false;
//         final List<dynamic> data = respose.data;
//         clothlist = data.map((e) => Cloth.fromJson(e)).toList();
//         debugPrint("list ${clothlist.length}");
//       }
//     } catch (e) {
//       print(e);
//     } finally {
//       notifyListeners();
//     }
//   }
// }

// class Cloth {
//   final String name;
//   final String image;

//   Cloth({required this.name, required this.image});
//   factory Cloth.fromJson(Map<String, dynamic> json) {
//     return Cloth(name: json['title'], image: json['image']);
//   }
// }

//   // int count = 0;

//   // void increment() {
//   //   count++;
//   //   notifyListeners();
//   // }

//   // void decrement() {
//   //   count--;
//   //   notifyListeners();
//   // }

