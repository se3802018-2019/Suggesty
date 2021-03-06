import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:suggesty/model/MovieDetails.dart';
import 'package:suggesty/model/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suggesty/suggest_movie.dart';
import 'package:toast/toast.dart';

class TmdbAPI extends StatefulWidget {
  @override
  _TmdbAPIState createState() => _TmdbAPIState();
}

class _TmdbAPIState extends State<TmdbAPI> {
  String url;
  String urlDetail;
  Movie movie;
  MovieDetails movieDetails;
  Future<MovieDetails> detailVeri;
  List<String> splittedList;
  int movID = 1;
  int pageNum = 1;
  int detailID = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailVeri = getMovies();
  }

  Future<MovieDetails> getMovies() async {
    var random = new Random();
    if (SuggestScreen.radioVal == "Random") {
      pageNum = random.nextInt(51);
      url =
          "https://api.themoviedb.org/3/discover/movie?api_key=2050b4781551574ea11b686357c54ca3&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=${pageNum.toString()}";
    } else if (SuggestScreen.radioVal == "Genre") {
      if (SuggestScreen.genreVal != null &&
          SuggestScreen.genreVal != "Choose a Genre" &&
          SuggestScreen.yearVal != null &&
          SuggestScreen.yearVal != "Choose a Year") {
        //genre and year selected

        url =
            "https://api.themoviedb.org/3/discover/movie?api_key=2050b4781551574ea11b686357c54ca3&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=${pageNum.toString()}&with_genres=${SuggestScreen.genreVal}&year=${SuggestScreen.yearVal}";
        print(
            "GENRE ${SuggestScreen.genreVal} AND YEAR SELECTED ${SuggestScreen.yearVal}");
      } else if (SuggestScreen.genreVal != null &&
          SuggestScreen.genreVal != "Choose a Genre") {
        //only genre selected
        url =
            "https://api.themoviedb.org/3/discover/movie?api_key=2050b4781551574ea11b686357c54ca3&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=${pageNum.toString()}&with_genres=${SuggestScreen.genreVal}";

        print("ONLY GENRE SELECTED");
      } else if (SuggestScreen.yearVal != null &&
          SuggestScreen.yearVal != "Choose a Year") {
        // only year selected
        print("ONLY YEAR SELECTED!");
        url =
            "https://api.themoviedb.org/3/discover/movie?api_key=2050b4781551574ea11b686357c54ca3&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=${pageNum.toString()}&year=${SuggestScreen.yearVal}";
      }
    } else {
      print("radioVal değerine ulaşılamadı");
    }

    movID = random.nextInt(19);

    var response = await http.get(url);
    var decodedJson = json.decode(response.body);
    movie = await Movie.fromJson(decodedJson);

    detailID = movie.results[movID].id;
    urlDetail =
        "https://api.themoviedb.org/3/movie/${detailID.toString()}?api_key=2050b4781551574ea11b686357c54ca3&language=en-US";

    var responseDetail = await http.get(urlDetail);
    var decodedDetailsJson = json.decode(responseDetail.body);
    movieDetails = MovieDetails.fromJson(decodedDetailsJson);

    return movieDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SUGGESTY"),
        ),
        body: FutureBuilder(
            future: detailVeri,
            builder: (context, AsyncSnapshot<MovieDetails> movie) {
              if (movie.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.pink,
                    ),
                  ),
                );
              } else if (movie.connectionState == ConnectionState.done) {
                // print(movie.data.results[0].toString());
                print("________******__________");
                print(movie.data.toString());
                return CustomScrollView(slivers: <Widget>[
                  SliverAppBar(
                    //title: Text("Sliver APP Bar", style: TextStyle(color: Colors.red,),),
                    backgroundColor: Colors.pink,
                    expandedHeight: 300,
                    floating: false,
                    //scroll işlemi tam olarak bitmeden app bar görünmeye başlar.
                    snap: false,
                    // floating ile birlikte true kullanılmalı!!! Sayfanın en altından üste doğru scroll hareketine başlandığı anda app bar aşşağıya doğru tamamen açılıyor.
                    pinned: true,
                    // app bar kapandıktan sonra banner gibi üstte görünmeye devam eder
                    flexibleSpace: FlexibleSpaceBar(
                      title: Container(
                        color: Colors.pink.withOpacity(0.6),
                        padding: EdgeInsets.all(2),
                        child: Text(
                          movie.data.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      centerTitle: true,
                      background: Image.network(
                        movie.data.posterPath != null
                            ? "https://image.tmdb.org/t/p/w500${movie.data.posterPath}"
                            : "https://i.gifer.com/1amw.gif",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(2),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                          sabitListeElemanlari(movieDetails, context)),
                    ),
                  ),
                ]);
              }
            }));
  }
}

void showToast(
  BuildContext context,
  String msg, {
  int duration,
  int gravity,
}) {
  Toast.show(
    msg,
    context,
    duration: 3,
    gravity: 10,
    textColor: Colors.white,
    backgroundColor: Colors.pink,
  );
}

List<Widget> sabitListeElemanlari(MovieDetails mov, BuildContext context) {
  return [
    GestureDetector(
      onTap: () {
        print("WATCHLIST EKLE");

        Firestore.instance.collection("movie").add({
          "title": "${mov.originalTitle}",
          "duration": "${mov.runtime}",
          "genre": "${mov.genres[0].name.toString()}",
          "picture": "https://image.tmdb.org/t/p/w500${mov.posterPath}"
        });

        showToast(context, "Added Successfuly!");
      },
      child: Container(
          color: Colors.purple,
          child: ListTile(
              title: Text(
                "Add to Watchlist",
                style: TextStyle(color: Colors.white),
              ),
              leading: Icon(
                Icons.live_tv,
                color: Colors.white,
              ),
              trailing: Icon(
                Icons.add,
                color: Colors.white,
              ))),
    ),
    SizedBox(
      height: 2,
    ),
    Divider(),
    Container(
      width: 200,
      child: Center(
        child: Text(
          mov.overview,
          overflow: TextOverflow.ellipsis,
          maxLines: 15,
          softWrap: true,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
    SizedBox(
      height: 2,
    ),
    Divider(),
    Container(
      color: Colors.pink.shade500,
      alignment: Alignment.center,
      child: ListTile(
        title: Text(
          "Genres",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: ListTile(
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: mov.genres
                    .map((map) => Align(
                        alignment: Alignment.center,
                        child: Chip(
                          elevation: 4,
                          backgroundColor: Colors.purple,
                          label: Text(
                            map.name,
                            style: TextStyle(color: Colors.white),
                          ),
                        )))
                    .toList())),
      ),
    ),
    Container(
      color: Colors.pink.shade500,
      alignment: Alignment.center,
      child: ListTile(
        title: Text(
          "Spoken Languages ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: ListTile(
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: mov.spokenLanguages
                    .map((map) => Chip(
                          elevation: 4,
                          backgroundColor: Colors.purple,
                          label: Text(
                            map.name,
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                    .toList())),
      ),
    ),
    Container(
      color: Colors.pink.shade500,
      alignment: Alignment.center,
      child: ListTile(
        title: Text(
          "Duration: " + mov.runtime.toString() + " mins",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: ListTile(
        title: Text(
          "Released: " + mov.releaseDate.toIso8601String().substring(0, 10),
          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    Container(
      color: Colors.pink.shade500,
      alignment: Alignment.center,
      child: ListTile(
        title: Text(
          "Average Vote: " + mov.voteAverage.toString(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ];
}
