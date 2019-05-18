import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
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
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.pushNamed(context, "/suggestMovie");
              },
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 6,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: RaisedButton(
              child: Text(
                "WATCHLIST",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.pushNamed(context, "/watchList");
              },
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 6,
          ),
        ],
      ),
    );
  }
}
