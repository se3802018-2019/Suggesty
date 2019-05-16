import 'package:flutter/material.dart';
import 'package:suggesty/first_screen.dart';
import 'package:suggesty/tmdb_api.dart';
import 'package:suggesty/suggest_movie.dart';
import 'package:suggesty/watch_list.dart';

void main() => runApp(MaterialApp(
  initialRoute: "/",
  routes: {
    "/": (context) => FirstScreen(),
    "/watchList": (context) => WatchList(),
    "/suggestMovie": (context) => SuggestScreen(),
    "/suggestMovie/imdbApi": (context) => TmdbAPI(),
  },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
    ));
