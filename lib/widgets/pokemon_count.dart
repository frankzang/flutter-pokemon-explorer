import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_explorer/config/api.dart';

class TotalPokemon extends StatefulWidget {
  TotalPokemon({Key key}) : super(key: key);

  _TotalPokemonState createState() => _TotalPokemonState();
}

class _TotalPokemonState extends State<TotalPokemon> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    getPokemonCount();

    return Container(
      child: Text(
        "Total pokemon: $_count",
        style: TextStyle(
            color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w400),
      ),
    );
  }

  getPokemonCount() async {
    try {
      var response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        if (!mounted) return;

        setState(() {
          _count = json.decode(response.body)["count"];
        });
      }
    } catch (e) {}
  }
}
