import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_explorer/config/api.dart';
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
  bool _isSearching = false;
  bool _notFound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 40),
                child: SearchInput(onFieldSubmitted: _searchPokemon)),
            !_isSearching
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: _pokemon != null ? SearchResult(_pokemon) : null,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CircularProgressIndicator()),
            Center(
              child: _notFound ? Text("Not found") : null,
            )
          ],
        ),
      ),
    );
  }

  _searchPokemon(String text) async {
    if (text == null) return;

    setState(() {
      _isSearching = true;
      _notFound = false;
    });

    var path = "$API_URL${text.toLowerCase()}";

    try {
      var response = await http.get(path);
      if (response.statusCode == 200 && mounted) {
        setState(() {
          _pokemon = Pokemon.fromJson(json.decode(response.body));
          _isSearching = false;
        });
      }
      if (response.statusCode == 404 && mounted) {
        setState(() {
          _pokemon = null;
          _notFound = true;
          _isSearching = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
