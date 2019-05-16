import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suggesty/imagePage.dart';
import 'dart:convert';
import 'dart:async';

import 'package:suggesty/model/MovieDetails.dart';
import 'package:suggesty/model/moviveFirebase.dart';

class WatchList extends StatefulWidget {
  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: scaffoldKey,
        appBar: AppBar(
          title: Text("WATCHLIST"),
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
          print("DETAILS?");

        },
        title: Text(movieFirebase.title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        leading: InkWell(
          onTap: (){
            print("image clicked");
            Navigator.of(context).push((MaterialPageRoute(builder: (context)=> ImagePage( imgPath:movieFirebase.picture))));
          },

            child: CircleAvatar(
              backgroundColor: Colors.pink,
              backgroundImage: NetworkImage(movieFirebase.picture),
              radius: 30,
            ),

        ),
        trailing: GestureDetector(
          child: Icon(Icons.remove_circle,color: Colors.pink,size: 25,),
          onTap: (){
            data.reference.delete();

            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(movieFirebase.title+" Deleted!", textAlign: TextAlign.center,),
              duration: Duration(seconds: 3),backgroundColor: Colors.purple,
            ));

            print("Deleted");

          },
        ),
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
