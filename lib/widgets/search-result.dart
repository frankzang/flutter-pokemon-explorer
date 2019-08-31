import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_explorer/models/pokemon.dart';
import 'package:pokemon_explorer/screens/pokemon-details.dart';

class SearchResult extends StatefulWidget {
  final Pokemon _pokemon;
  SearchResult(this._pokemon);

  @override
  State<StatefulWidget> createState() {
    return _SearchResultState();
  }
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Hero(
                              tag: "pokemon_hero${widget._pokemon.id}",
                              child: CachedNetworkImage(
                                width: 70,
                                imageUrl:
                                    widget._pokemon.sprites["front_default"],
                                placeholder: (context, url) =>
                                    new CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    new Icon(Icons.error),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "N° ${widget._pokemon.id.toString()}",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    "${widget._pokemon.name.substring(0, 1).toUpperCase() + widget._pokemon.name.substring(1)}",
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black54),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PokemonDetails(widget._pokemon, widget._pokemon.id)));
        },
      ),
    );
  }
}
