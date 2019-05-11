import 'package:flutter/material.dart';

class SuggestScreen extends StatefulWidget {
  @override
  _SuggestScreenState createState() => _SuggestScreenState();
}

class _SuggestScreenState extends State<SuggestScreen> {
  String secilenTur;
  String secilenRadio;

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
                    "Rastgele",
                    style: TextStyle(fontSize: 20),
                  ),
                  value: "Rastgele",
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
                    "Türe Göre",
                    style: TextStyle(fontSize: 20),
                  ),
                  value: "TüreGöre",
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
                        "Komedi",
                        style: TextStyle(fontSize: 20),
                      ),
                      value: "Komedi",
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "Korku",
                        style: TextStyle(fontSize: 20),
                      ),
                      value: "Korku",
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "Aksiyon",
                        style: TextStyle(fontSize: 20),
                      ),
                      value: "Aksiyon",
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      secilenTur = value;
                      print(value);
                    });
                  },
                  hint: Text(
                    "Bir Tür Seçin",
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
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
