import 'package:movie_api/movies.dart';

class MovieCategory {
  String category;
  String title;

  // ignore: non_constant_identifier_names
  MovieCategory({required this.category, required this.title});
}

class Category {
  final List<MovieCategory> _category = [
    MovieCategory(category: 'now_playing', title: 'Now Playing'),
    MovieCategory(category: 'top_rated', title: 'Top Rated'),
    MovieCategory(category: 'upcoming', title: 'Upcoming')
  ];
  String getCategory(indexNum) {
    return _category[indexNum].category;
  }

  String getTitle(indexNum) {
    return _category[indexNum].title;
  }

  int getLength() {
    return _category.length;
  }
}
