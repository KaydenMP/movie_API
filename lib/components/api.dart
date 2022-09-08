import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API {
  Future getData(String type) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$type?api_key=050c28541f900007285c3020069bfd62&language=en-US&page=1');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      return const CircularProgressIndicator();
    }
  }
}
