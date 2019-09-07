import 'package:flutter/material.dart';
import 'package:pokemon_explorer/screens/dashboard.dart';
import 'package:pokemon_explorer/screens/search_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.redAccent,
          cursorColor: Colors.redAccent,
          fontFamily: "Yanone"),
      home: Dashboard(),
      routes: {
        "search": (context) => SearchPage(),
      },
    );
  }
}
