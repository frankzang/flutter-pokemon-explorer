import 'package:flutter/material.dart';
import 'package:pokemon_explorer/models/pokemon.dart';
import 'package:pokemon_explorer/widgets/stats-chart.dart';

class PokemonDetails extends StatefulWidget {
  final Pokemon _pokemon;
  final int _pokemonNumber;

  PokemonDetails(this._pokemon, this._pokemonNumber);

  @override
  State<StatefulWidget> createState() {
    return _PokemonDetailsState();
  }
}

class _PokemonDetailsState extends State<PokemonDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        title: Text(
          widget._pokemon.name.substring(0, 1).toUpperCase() +
              widget._pokemon.name.substring(1),
          style: TextStyle(
              color: Colors.black54,
              fontSize: 32,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w400),
        ),
      ),
      body: Column(
        children: <Widget>[
          Hero(
              tag: "pokemon_hero${widget._pokemonNumber}",
              child: _pokemonSprite(
                  name: "Front",
                  image: widget._pokemon.sprites["front_default"])),
          Container(height: 200, child: StatsChart(widget._pokemon))
        ],
      ),
    );
  }

  _pokemonSprite({String image, String name}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 130,
        child: Column(
          children: <Widget>[
            Image(
              image: NetworkImage(image),
              fit: BoxFit.contain,
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
