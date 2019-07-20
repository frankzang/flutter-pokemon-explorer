class Pokemon {
  String name;
  int id;
  Map sprites;

  Pokemon({this.name, this.id, this.sprites});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        name: json["name"], id: json["id"], sprites: json["sprites"]);
  }
}
