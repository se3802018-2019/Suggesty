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
      body: Center(child: Text("WATCH LIST PAGE!"),)
    );}
}

