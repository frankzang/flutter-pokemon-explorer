import 'package:flutter/material.dart';
import 'package:pokemon_explorer/models/pokemon.dart';

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
      body: Container(
          child: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            delegate: SliverChildBuilderDelegate((context, index) {
              return Hero(
                  tag: "pokemon_hero${widget._pokemonNumber}",
                  child: _pokemonSprite(
                      name: "Front",
                      image: widget._pokemon.sprites["front_default"]));
            }, childCount: 1),
          )
        ],
      )),
    );
  }

  _pokemonSprite({String image, String name}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Image(
            image: NetworkImage(image),
            fit: BoxFit.contain,
            height: 100,
          ),
          Text(
            name,
            style: TextStyle(color: Colors.black54),
          )
        ],
      ),
    );
  }
}

class PokeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[],
    );
  }
}
