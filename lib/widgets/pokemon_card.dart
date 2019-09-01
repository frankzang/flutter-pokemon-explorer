import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_explorer/config/api.dart';
import 'package:pokemon_explorer/models/pokemon_model_dart';
import 'package:pokemon_explorer/screens/pokemon_details_page.dart';

class PokemonCard extends StatefulWidget {
  final int _pokemonNumber;

  PokemonCard(this._pokemonNumber);

  @override
  State<StatefulWidget> createState() {
    return _PokemonCardState();
  }
}

class _PokemonCardState extends State<PokemonCard>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  PokemonModel _pokemon;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getPokemon();

    return FadeTransition(
      opacity: _animation,
      child: Card(
          elevation: 0,
          color: Colors.grey[200],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _pokemon != null
                  ? Container(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                            tag: "pokemon_hero${widget._pokemonNumber}",
                            child: SingleChildScrollView(
                              padding: EdgeInsets.all(8),
                              child: SizedBox(
                                height: 80,
                                width: 80,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: 70,
                                  imageUrl: _pokemon.sprites["front_default"],
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            "N°${_pokemon.id.toString()}",
                            style: TextStyle(
                                color: Colors.black38,
                                fontFamily: "Yanone",
                                fontSize: 12,
                                letterSpacing: .5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          _pokemon.name.substring(0, 1).toUpperCase() +
                              _pokemon.name.substring(1),
                          style: TextStyle(
                              color: Colors.black54,
                              letterSpacing: .8,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))
                  : null,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PokemonDetails(_pokemon, widget._pokemonNumber)));
            },
          )),
    );
  }

  getPokemon() async {
    if (_pokemon != null) {
      return;
    }

    var path = "$apiUrl${widget._pokemonNumber}";

    try {
      var response = await http.get(path);
      if (response.statusCode == 200 && mounted) {
        setState(() {
          _pokemon = PokemonModel.fromJson(json.decode(response.body));
        });
        _controller.forward();
      }
    } catch (e) {}
  }
}