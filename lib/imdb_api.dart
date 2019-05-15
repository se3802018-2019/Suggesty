import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:suggesty/model/Film.dart';
import 'dart:math';

class ImdbAPI extends StatefulWidget {
  @override
  _ImdbAPIState createState() => _ImdbAPIState();
}

class _ImdbAPIState extends State<ImdbAPI> {
  String url =
      "http://www.omdbapi.com/?apikey=2ff51865&i=tt005"; //68646  +5 haneli bir sayi ekle
  Film film;
  Future<Film> veri;
  List<String> splittedList;
  String splitThisString;

  Future<Film> filmGetir() async {
    var respone = await http.get(url);
    var decodedJson = json.decode(respone.body);

    film = Film.fromJson(decodedJson);

    return film;
  }

  @override
  void initState() {
    super.initState();
    url += _urlCreator();
    print("NEW URL>>>>> $url");
    setState(() {
      veri = filmGetir().catchError((error) {
        print("HATA >>>>!!!! $error");
      });
      // TODO: implement initState
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SUGGESTION"),
        ),
        body: FutureBuilder(
          future: veri,
          builder: (context, AsyncSnapshot<Film> gelenFilm) {
            if (gelenFilm.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (gelenFilm.connectionState == ConnectionState.done) {
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
                    title: Text(gelenFilm.data.title),
                    centerTitle: true,
                    background: Image.network(
                      gelenFilm.data.poster != "N/A"
                          ? gelenFilm.data.poster
                          : "https://dwsinc.co/wp-content/uploads/2018/05/image-not-found.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  // satırda gösterilecek eleman sayısı
                  delegate: SliverChildListDelegate([      Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              gelenFilm.data.imdbRating != "N/A"
                                  ? "Imdb : " +  gelenFilm.data.imdbRating
                                  : "NO RATING",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink),
                            ),
                            Text(
                              gelenFilm.data.runtime != "N/A" ? gelenFilm.data.runtime : "NO TIME",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink),
                            ),
                            Text(
                              gelenFilm.data.released != "N/A" ? gelenFilm.data.released : "NO YEAR",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            gelenFilm.data.country != "N/A" ? gelenFilm.data.country : "NO COUNTRY",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          ),
                          Text(
                            gelenFilm.data.language != "N/A" ? gelenFilm.data.language : "NO LANG",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.pink,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Actors",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: _splitString(gelenFilm.data.actors)
                                .map((writer) => Chip(
                              elevation: 2,
                              backgroundColor: Colors.purple,
                              label: Text(
                                writer,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                                .toList(),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.pink,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Genre",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: _splitString(gelenFilm.data.genre)
                                .map((writer) => Chip(
                              elevation: 2,
                              backgroundColor: Colors.purple,
                              label: Text(
                                writer,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                                .toList(),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.pink,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Writers",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: _splitString(gelenFilm.data.writer)
                                .map((writer) => Chip(
                              elevation: 2,
                              backgroundColor: Colors.purple,
                              label: Text(
                                writer,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                                .toList(),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.pink,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Directors",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: _splitString(gelenFilm.data.director)
                                .map((writer) => Chip(
                              elevation: 2,
                              backgroundColor: Colors.purple,
                              label: Text(
                                writer,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                                .toList(),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            splashColor: Colors.purple,
                            child: Text("I DID NOT LIKE IT",
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold)),
                            color: Colors.red,
                            onPressed: () {

                            },
                            elevation: 1,
                          ),
                          RaisedButton(
                            splashColor: Colors.purple,
                            child: Text("ADD WATCH LIST",
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold)),
                            color: Colors.green,
                            onPressed: () {},
                            elevation: 1,
                          ),
                        ],
                      )
                    ],
                  ),]),
                )
              ]);
            }
          },
        ));
  }

  List<Widget> sabitListeElemanlari(String listeTuru) {
    return [

    ];
  }

  List<String> _splitString(String splitThisString) {
    splittedList = splitThisString.split(",");

    return splittedList;
  }

  String _urlCreator() {
    String randomNumber = "";
    int returnedN = _randomDigit();

    for (int i = 0; i < 5; i++) {
      randomNumber += _randomDigit().toString();
      print(_randomDigit().toString());
    }

    print("RANDOM NUMBER==>> " + randomNumber);

    return randomNumber;
  }

  int _randomDigit() {
    var random = new Random();
    return random.nextInt(10);
  }
}
