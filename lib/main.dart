import 'package:flutter/material.dart';
import 'package:movie_api/signIn.dart';
import 'package:movie_api/signUp.dart';
import 'package:movie_api/movies.dart';
import 'package:movie_api/overview.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const AppSignUp(),
         '/login':(context) => const SignInScreen(),
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


