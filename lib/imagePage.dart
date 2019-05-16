import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  var imgPath;

  ImagePage({this.imgPath});
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("SUGGESTY"),
    ),
      body: FadeInImage.assetNetwork(width: double.infinity,height: double.infinity,placeholder: "https://i.gifer.com/1amw.gif", image: widget.imgPath,fit: BoxFit.fill,alignment: Alignment.topCenter,) ,
    );
  }
}
