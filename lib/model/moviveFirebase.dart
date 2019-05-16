import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class MovieFireBase {

  String title;
   int votes;
   String duration;
   String genre;
   String picture;

   DocumentReference reference;

  MovieFireBase.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] !=null),
        assert(map['duration'] !=null),
        assert(map['genre'] != null),
        assert(map['picture'] != null),
        title=map['title'],
        duration=map['duration'],
        genre=map['genre'],
        picture=map['picture'];



  MovieFireBase.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data,reference: snapshot.reference);






}