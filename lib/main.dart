import 'package:flutter/material.dart';
import 'main_page.dart';


void main() => runApp(new NewsApp());

class NewsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Indonesia News',
      theme: new ThemeData(
        accentColor: Colors.blueAccent,
        primarySwatch: Colors.blueGrey
      ),
      home: new NewsHomePage(title: 'News Indo'),
    );
  }
}