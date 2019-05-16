import 'package:flutter/material.dart';

class SuggestScreen extends StatefulWidget {
  @override
  _SuggestScreenState createState() => _SuggestScreenState();
}

class _SuggestScreenState extends State<SuggestScreen> {
  String secilenTur;
  String secilenRadio="Random";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
                  groupValue: secilenRadio,
                  onChanged: (secim) {
                    setState(() {
                      secilenRadio = secim;
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
                  groupValue: secilenRadio,
                  onChanged: (secim) {
                    setState(() {
                      secilenRadio = secim;
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
                child: DropdownButton<String>(
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        "Comedy",
                        style: TextStyle(fontSize: 20),
                      ),
                      value: "Comedy",
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "Horror",
                        style: TextStyle(fontSize: 20),
                      ),
                      value: "Horror",
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "Action",
                        style: TextStyle(fontSize: 20),
                      ),
                      value: "Action",
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      secilenTur = value;
                      print(value);
                    });
                  },
                  hint: Text(
                    "Choose a Genre",
                    style: TextStyle(fontSize: 20),
                  ),
                  value: secilenTur,
                ),
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

                    if(secilenRadio == "Random"){
                    Navigator.pushNamed(context, "/suggestMovie/imdbApi");
                    }else if( secilenRadio == "TüreGöre"){
                      print("TÜRE GÖRE SEÇİM YAPILD!");
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
