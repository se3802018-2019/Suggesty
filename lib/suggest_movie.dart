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
    double height= MediaQuery.of(context).size.height ;
    return Scaffold(
      appBar: AppBar(
        title: Text("SUGGEST A MOVIE"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile(
                  activeColor: Colors.purple,
                  title: Text("Rastgele"),
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
                  title: Text("Türe Göre"),
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
                padding: const EdgeInsets.only(right: 60),
                child: DropdownButton<String>(
                  items: [
                    DropdownMenuItem(
                      child: Text("Komedi"),
                      value: "Komedi",
                    ),
                    DropdownMenuItem(
                      child: Text("Korku"),
                      value: "Korku",
                    ),
                    DropdownMenuItem(
                      child: Text("Aksiyon"),
                      value: "Aksiyon",
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      secilenTur = value;
                      print(value);
                    });
                  },
                  hint: Text("Bir Tür Seçin"),
                  value: secilenTur,
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: height-300) ),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  color: Colors.pink,
                  child: Text("SUGGEST",style: TextStyle(color: Colors.white),),
                  
                  onPressed: (){

                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
