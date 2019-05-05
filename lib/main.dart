import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Suggesty(),
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
    ));

class Suggesty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SUGGESTY"),
        leading: Icon(Icons.subscriptions),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: RaisedButton(
              child: Text(
                "SUGGEST A MOVIE",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              color: Colors.pinkAccent,
              onPressed: () {},
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 4,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: RaisedButton(
              child: Text(
                "FAVOURITE LIST",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              color: Colors.pinkAccent,
              onPressed: () {},
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 4,
          ),
        ],
      ),
    );
  }
}
