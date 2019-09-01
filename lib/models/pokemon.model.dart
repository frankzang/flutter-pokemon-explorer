class PokemonModel {
  String name;
  int id;
  Map sprites;
  List<Stats> stats;

  PokemonModel({this.name, this.id, this.sprites, this.stats});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    List<Stats> stats = (json["stats"] as List).map((stat) {
      return Stats(stat["base_stat"], stat["stat"]);
    }).toList();

    return PokemonModel(
        name: json["name"],
        id: json["id"],
        sprites: json["sprites"],
        stats: stats);
  }
}

class Stats {
  int baseStat;
  Map<String, dynamic> stat;
  Stats(this.baseStat, this.stat);
}
