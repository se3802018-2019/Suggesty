import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:async';

import 'package:suggesty/model/MovieDetails.dart';
import 'package:suggesty/model/moviveFirebase.dart';

class WatchList extends StatefulWidget {
  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("WATCH LIST"),
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("movie").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator(
            backgroundColor: Colors.pink,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.pinkAccent,
            ),
          );
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      reverse: true,
      padding: EdgeInsets.only(top: 5),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final movieFirebase = MovieFireBase.fromSnapshot(data);

    return Card(
      elevation: 2,
      child: ListTile(
        onTap: () {
          print("Deleted");
        },
        title: Text(movieFirebase.title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        leading: CircleAvatar(
          backgroundColor: Colors.pink,
          backgroundImage: NetworkImage(movieFirebase.picture),
          radius: 30,
        ),
        trailing: Icon(Icons.remove_circle,color: Colors.pink,size: 25,),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
            ),
            Text(movieFirebase.genre, style:TextStyle(color: Colors.black),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
            ),
          ],
        ),

      ),
    );
  }
}
