import 'package:flutter/material.dart';
import 'package:pokemon_explorer/models/pokemon_model.dart';
import 'package:pokemon_explorer/widgets/pokemon_card.dart';
import 'package:pokemon_explorer/widgets/pokemon_count.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_explorer/config/api.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final List<PokemonModel> pokemonList = [];

  bool _isGettingPokemon = false;

  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = new ScrollController();
    getMorePokemon();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            "Search pokemon",
            style: TextStyle(fontFamily: "Roboto"),
          ),
          icon: Icon(Icons.search),
          backgroundColor: Colors.redAccent,
          onPressed: () {
            Navigator.of(context).pushNamed("search");
          },
        ),
        body: Container(
          child: NotificationListener<ScrollNotification>(
              onNotification: _onScrollNotification,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return index == 0
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 70, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Pokemon Explorer",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 32,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  TotalPokemon()
                                ],
                              ),
                            )
                          : null;
                    }),
                  ),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return GridTile(
                        child: PokemonCard(pokemonList[index]),
                      );
                    }, childCount: pokemonList.length),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 100),
                        child: Center(
                          child: _isGettingPokemon
                              ? CircularProgressIndicator()
                              : null,
                        ),
                      )
                    ]),
                  ),
                ],
              )),
        ));
  }

  bool _onScrollNotification(ScrollNotification scrollInfo) {
    if (_isGettingPokemon) return null;

    if (pokemonList.length < 1) return null;

    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      getMorePokemon();
    }
    return null;
  }

  getMorePokemon() async {
    setState(() {
      _isGettingPokemon = true;
    });

    var length = pokemonList.length;

    for (var i = length + 1; i < length + 10; i++) {
      PokemonModel pokemon = await getPokemon(i);

      if (pokemon != null) {
        pokemonList.add(pokemon);
      }
    }

    setState(() {
      _isGettingPokemon = false;
    });
  }

  Future<PokemonModel> getPokemon(int _pokemonNumber) async {
    var path = "$apiUrl${_pokemonNumber.toString()}";

    try {
      var response = await http.get(path);
      if (response.statusCode == 200 && mounted) {
        return PokemonModel.fromJson(json.decode(response.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
