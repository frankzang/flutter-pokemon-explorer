import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonCountProvider extends ChangeNotifier {
  int _count;
  get count => _count;

  getPokemonCount() async {
    var path = "https://pokeapi.co/api/v2/pokemon/";
    try {
      var response = await http.get(path);
      if (response.statusCode == 200) {
        _count = json.decode(response.body)["count"];
        notifyListeners();
      }
    } catch (e) {}
  }
}
