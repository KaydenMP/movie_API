import 'package:flutter/material.dart';
import 'package:movie_api/login.dart';
import 'package:movie_api/movies.dart';
import 'package:movie_api/overview.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const AppLogin(),
        '/second':(context) => const MoviesPage(),
        '/third': (context) => const Overview()
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      // home: const MyHomePage(),
    );
  }
}


