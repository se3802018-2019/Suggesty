import 'package:flutter/material.dart';
import 'package:suggesty/first_screen.dart';
import 'package:suggesty/imdb_api.dart';
import 'package:suggesty/suggest_movie.dart';
import 'package:suggesty/watch_list.dart';

void main() => runApp(MaterialApp(
  initialRoute: "/firstScreen",
  routes: {
    "/": (context) => FirstScreen(),
    "/watchList": (context) => WatchList(),
    "/suggestMovie": (context) => SuggestScreen(),
    "/suggestMovie/imdbApi": (context) => ImdbAPI(),
  },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
    ));
