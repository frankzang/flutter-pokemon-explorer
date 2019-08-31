import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_explorer/models/pokemon.dart';
import 'package:pokemon_explorer/utils/capitalize.dart';
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                children: <Widget>[
                  Text(
                    capitalize(widget._pokemon.name),
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 32,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "#${widget._pokemon.id.toString()}",
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              )),
          Hero(
              tag: "pokemon_hero${widget._pokemonNumber}",
              flightShuttleBuilder: (
                BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext,
              ) {
                return fromHeroContext.widget;
              },
              child: _pokemonSprite(
                  name: "Front",
                  image: widget._pokemon.sprites["front_default"])),
          Container(height: 250, child: StatsChart(widget._pokemon))
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
            SizedBox(
              height: 80,
              width: 80,
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
