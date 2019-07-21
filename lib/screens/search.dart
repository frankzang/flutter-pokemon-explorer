import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_explorer/models/pokemon.dart';
import 'package:pokemon_explorer/widgets/search-input.dart';
import 'package:pokemon_explorer/widgets/search-result.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  Pokemon _pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 70,
              ),
              child: Text(
                "Search by pokemon name or number",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 32,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SearchInput(onFieldSubmitted: _searchPokemon)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: _pokemon != null ? SearchResult(_pokemon) : null,
            )
          ],
        ),
      ),
    );
  }

  _searchPokemon(String text) async {
    if (text == null) return;

    var path = "https://pokeapi.co/api/v2/pokemon/${text.toLowerCase()}";

    try {
      var response = await http.get(path);
      if (response.statusCode == 200 && mounted) {
        setState(() {
          _pokemon = Pokemon.fromJson(json.decode(response.body));
        });
      }
    } catch (e) {}
  }
}
