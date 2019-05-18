import 'package:flutter/material.dart';
import 'package:suggesty/model/Genre.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class SuggestScreen extends StatefulWidget {
  static String radioVal;
  static String genreVal;
  @override
  _SuggestScreenState createState() => _SuggestScreenState();
}

class _SuggestScreenState extends State<SuggestScreen> {
  int genreValue;
  String radioValue = "Random";
  String urlGenre;
  Genre genreObj;

  Future<Genre> genreData;

  Future<Genre> getGenres() async {
    urlGenre =
        "https://api.themoviedb.org/3/genre/movie/list?api_key=2050b4781551574ea11b686357c54ca3&language=en-US";

    var response = await http.get(urlGenre);
    var decodedJson = json.decode(response.body);
    genreObj = await Genre.fromJson(decodedJson);



    return genreObj;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SuggestScreen.radioVal="Random";
    genreData = getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SUGGEST A MOVIE"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile(
                  activeColor: Colors.purple,
                  title: Text(
                    "Random",
                    style: TextStyle(fontSize: 20),
                  ),
                  value: "Random",
                  groupValue: radioValue,
                  onChanged: (secim) {
                    setState(() {
                      radioValue = secim;
                      SuggestScreen.radioVal=secim;
                      print(secim);
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  activeColor: Colors.purple,
                  title: Text(
                    "Genre",
                    style: TextStyle(fontSize: 20),
                  ),
                  value: "Genre",
                  groupValue: radioValue,
                  onChanged: (secim) {
                    setState(() {
                      SuggestScreen.radioVal=secim;
                      radioValue = secim;
                      print("static radioVal => " +SuggestScreen.radioVal);

                      print(secim);
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: FutureBuilder(
                    future: genreData,
                    builder: (context, AsyncSnapshot<Genre> snapGenre) {
                      if (snapGenre.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.pink,
                            ),
                          ),
                        );
                      } else if (snapGenre.connectionState ==
                          ConnectionState.done) {

                        snapGenre.data.genres.map((map) {
                          print("MAP: " + map.name);
                        });

                        print("*/*/*/*/* " +
                            snapGenre.data.genres[0].name +
                            " *************--**-*");

                        return DropdownButton(
                          hint: Text("Choose a Genre"),
                          value: genreValue,
                            onChanged: (genre) {
                              print("SEÇİLEN ITEM => " +genre.toString());
                              SuggestScreen.genreVal=genre.toString();
                              print("static genreVal => " +SuggestScreen.genreVal);
                              setState(() {
                                genreValue = genre;

                              });
                            },
                            items: snapGenre.data.genres
                                .map((map) => DropdownMenuItem(
                                      child: Text(map.name),
                                      value: map.id,
                                    ))
                                .toList());
                      }
                    }),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 80.0)),
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: RaisedButton(
                  color: Colors.pink,
                  child: Text(
                    "SUGGEST",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    if (radioValue == "Random") {

                      Navigator.pushNamed(context, "/suggestMovie/imdbApi");
                    } else if (radioValue == "Genre") {

                      print("TÜRE GÖRE SEÇİM YAPILD!");
                      Navigator.pushNamed(context, "/suggestMovie/imdbApi");

                    }

                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
