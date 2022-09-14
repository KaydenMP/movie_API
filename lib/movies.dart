import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_api/components/movieCategory.dart';
import 'components/api.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

List movieResults = [];
int index = 0;
int i = 0;
int ind = 0;
var data;
var shouldPop;

class _MoviesPageState extends State<MoviesPage> {
  getResults() async {
    await API().getData(movies.getCategory(ind)).then((value) {
      setState(() {
        data = value;
      });
    });
    setState(() {
      movieResults = data['results'];
    });
  }

  Category movies = Category();
  @override
  Widget build(BuildContext context) {
    getResults();
    return WillPopScope(
      onWillPop: () async {
        shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure you want to logout?'),
                actionsAlignment: MainAxisAlignment.spaceAround,
                actions: [
                  TextButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text('Yes')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No'))
                ],
              );
            });
        return shouldPop!;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blueGrey),
                  child: Text('Category')),
              Expanded(
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return ListTile(
                      leading: const Icon(Icons.movie_sharp),
                      title: Text(movies.getTitle(index)),
                      onTap: () {
                        ind = index;
                        Navigator.pop(context);
                      },
                    );
                  }),
                  itemCount: movies.getLength(),
                ),
              ),
            ],
          ),
        ),
        body: Stack(fit: StackFit.expand, children: [
          Image.asset(
            'assets/movie_background.jpg',
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                ' ${movies.getTitle(ind)} Movies',
                style:
                    GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: movieResults.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            i = index;
                            Navigator.pushNamed(context, '/third');
                          });
                        },
                        leading: Container(
                          height: 150,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500${movieResults[index]['poster_path']}',
                              placeholder: (context, url) => const Image(
                                  image: AssetImage(
                                      'assets/popcorn-removebg-preview.png')),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          movieResults[index]['original_title'],
                          style: const TextStyle(fontSize: 15),
                        ),
                        subtitle: Text(
                            'Voting : ${movieResults[index]['vote_average']}/10'),
                      );
                    })),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
