import 'package:flutter/material.dart';
import 'package:pokemon_explorer/widgets/pokemon-card.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _itemCount = 15;

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
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 70),
                              child: Text(
                                "Pokemon Explorer",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 32,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w400),
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
                        child: PokemonCard(index + 1),
                      );
                    }, childCount: _itemCount),
                  )
                ],
              )),
        ));
  }

  bool _onScrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      setState(() {
        _itemCount = _itemCount + 5;
      });
      return null;
    }
    return null;
  }
}