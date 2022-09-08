import 'dart:ui';

import 'package:flutter/material.dart';
import 'movies.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500${movieResults[i]['poster_path']}',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  IconButton(
                      onPressed: (() {
                        setState(() {
                          Navigator.pop(context);
                        });
                      }),
                      icon: const Icon(Icons.arrow_back)),
                      SizedBox(width: 30,),
                  SizedBox(
                    height: 300,
                    width: 200,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500${movieResults[i]['poster_path']}',
                          placeholder: (context, url) => const Image(
                              image: AssetImage(
                                  'assets/popcorn-remove-preview.png')),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movieResults[i]['original_title'],
                          style: GoogleFonts.aBeeZee(fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${movieResults[i]['vote_average']}/10',
                      style: GoogleFonts.aBeeZee(fontSize: 20),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  movieResults[i]['overview'],
                  style: GoogleFonts.aleo(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
