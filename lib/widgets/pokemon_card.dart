import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_explorer/models/pokemon_model.dart';
import 'package:pokemon_explorer/screens/pokemon_details_page.dart';
import 'package:pokemon_explorer/utils/capitalize.dart';

class PokemonCard extends StatefulWidget {
  final PokemonModel _pokemon;

  const PokemonCard(this._pokemon);

  @override
  State<StatefulWidget> createState() {
    return _PokemonCardState();
  }
}

class _PokemonCardState extends State<PokemonCard>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: widget._pokemon != null
                ? Container(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Hero(
                          tag: "pokemon_hero${widget._pokemon.id}",
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(8),
                            child: SizedBox(
                              height: 80,
                              width: 80,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: 70,
                                imageUrl:
                                    widget._pokemon.sprites["front_default"],
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
                          "N°${widget._pokemon.id.toString()}",
                          style: TextStyle(
                              color: Colors.black38,
                              fontFamily: "Yanone",
                              fontSize: 12,
                              letterSpacing: .5,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        capitalize(widget._pokemon.name),
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
                        PokemonDetails(widget._pokemon, widget._pokemon.id)));
          },
        ));
  }
}
