import 'package:flutter/material.dart';
import 'package:suggesty/model/Genre.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:toast/toast.dart';

class SuggestScreen extends StatefulWidget {
  static String radioVal;
  static String genreVal;
  static String yearVal;

  @override
  _SuggestScreenState createState() => _SuggestScreenState();
}

class _SuggestScreenState extends State<SuggestScreen> {
  int genreValue;
  String yearVal;
  String radioValue = "Random";
  String urlGenre;
  Genre genreObj;
  Key dropDownKey = GlobalKey();

  Future<Genre> genreData;
  Future<List<String>> yearsData;

  Future<Genre> getGenres() async {
    urlGenre =
        "https://api.themoviedb.org/3/genre/movie/list?api_key=2050b4781551574ea11b686357c54ca3&language=en-US";

    var response = await http.get(urlGenre);
    var decodedJson = json.decode(response.body);
    genreObj = await Genre.fromJson(decodedJson);

    return genreObj;
  }

  Future<List<String>> getYears() async {
    var response = await generateYears();

    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SuggestScreen.radioVal = "Random";
    SuggestScreen.yearVal ="Choose a Year";
    SuggestScreen.genreVal ="Choose a Genre";
    genreData = getGenres();
    yearsData = getYears();
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
                      SuggestScreen.radioVal = secim;
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
                      SuggestScreen.radioVal = secim;
                      radioValue = secim;
                      print("static radioVal => " + SuggestScreen.radioVal);

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

                        return DropdownButton(
                            hint: Text("Choose a Genre"),
                            value: genreValue,
                            onChanged: (genre) {
                              print("SEÇİLEN ITEM => " + genre.toString());
                              SuggestScreen.genreVal = genre.toString();
                              print("static genreVal => " +
                                  SuggestScreen.genreVal);
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
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: FutureBuilder(
                    future: yearsData,
                    builder: (context, AsyncSnapshot<List<String>> snapYear) {
                      if (snapYear.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.pink,
                            ),
                          ),
                        );
                      } else if (snapYear.connectionState ==
                          ConnectionState.done) {
                        return DropdownButton(
                            hint: Text("Choose a Year"),
                            value: yearVal,
                            onChanged: (year) {
                              print("SEÇİLEN YIL => " + year.toString());
                              SuggestScreen.yearVal = year.toString();
                              print("static genreVal => " +
                                  SuggestScreen.yearVal);
                              setState(() {
                                yearVal = year.toString();
                              });
                            },
                            items: snapYear.data
                                .map((map) => DropdownMenuItem(
                                      child: Text(map.toString()),
                                      value: map.toString(),
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
                      if (SuggestScreen.yearVal != null &&
                          SuggestScreen.yearVal != "Choose a Year" &&
                          SuggestScreen.genreVal != null &&
                          SuggestScreen.genreVal != "Choose a Genre")
                      {
                        print("genre and YEAR SELECTED");
                        Navigator.pushNamed(context, "/suggestMovie/imdbApi");


                        //year and genre selected
                      } else if (SuggestScreen.genreVal != null &&
                      SuggestScreen.genreVal != "Choose a Genre") {
                        //only genre selected
                        print("genre SELECTED");
                        Navigator.pushNamed(context, "/suggestMovie/imdbApi");
                      } else if (SuggestScreen.yearVal != null &&
                          SuggestScreen.yearVal != "Choose a Year") {
                        //only year selected
                        print("YEAR SELECTED");
                        Navigator.pushNamed(context, "/suggestMovie/imdbApi");

                      } else {
                        //nothing selected
                        showToast(context, "Please choose a genre or year!");
                      }
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

  List<String> generateYears() {
    List<String> years = List();
    var now = new DateTime.now();
    for (int i = now.year; i >= 1960; i--) {
      years.add(i.toString());
    }

    return years;
  }
}
