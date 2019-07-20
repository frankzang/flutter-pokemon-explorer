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
            Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SearchInput(onFieldSubmitted: _searchPokemon)),
            Container(
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
