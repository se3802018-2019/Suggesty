import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

import 'package:suggesty/model/Film.dart';

class WatchList extends StatefulWidget {
  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  List<Film> tumFilmler;
  Icon favIcon = Icon(Icons.favorite,color: Colors.purple,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WATCH LIST"),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: veriKaynaginiOku(),
            builder: (context, sonuc) {
              if (sonuc.hasData) {
                tumFilmler = sonuc.data;

                return ListView.builder(

                    itemCount: tumFilmler.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          onTap: (){
                            },

                          leading: Icon(Icons.movie),
                          title: Text(
                            tumFilmler[index].name,
                            style:
                                TextStyle(fontSize: 18, color: Colors.purple),
                          ),
                          subtitle: Text(tumFilmler[index].genre),
                          trailing: favIcon,
                        ),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }

  Future<List> veriKaynaginiOku() async {
    var gelenVeri =
        await DefaultAssetBundle.of(context).loadString(("assets/film.json"));

    List<Film> filmlerListesi =
        (json.decode(gelenVeri) as List).map((mapYapisi) {
      return Film.fromJsonMap(mapYapisi);
    }).toList();

    return filmlerListesi;
  }
}
