import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_explorer/models/pokemon.dart';
import 'package:pokemon_explorer/screens/pokemon-details.dart';
import 'package:pokemon_explorer/widgets/search-input.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  Pokemon _pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SearchInput(_searchPokemon)),
            Container(
              child: _pokemon != null
                  ? ListTile(
                      leading: Container(
                          width: 50,
                          child: Hero(
                            tag: "pokemon_hero${_pokemon.id}",
                            child: Image(
                              image: NetworkImage(
                                  _pokemon.sprites["front_default"]),
                            ),
                          )),
                      title: Text(_pokemon.name.substring(0, 1).toUpperCase() +
                          _pokemon.name.substring(1)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PokemonDetails(_pokemon, _pokemon.id)));
                      },
                    )
                  : null,
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
