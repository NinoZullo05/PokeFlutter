class Pokemon {
  final int id;
  final String name;
  final String urlSprite;
  final String urlImage;
  final double weight;
  final double height;
  final List<String> typesList;
  final List<String> abilitiesList;

  Pokemon({
    required this.id,
    required this.name,
    required this.urlSprite,
    required this.urlImage,
    required this.weight,
    required this.height,
    required this.typesList,
    required this.abilitiesList,
  });

  Pokemon.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        urlSprite = json["sprites"]["front_default"],
        urlImage = json["sprites"]["other"]["official-artwork"]["front_default"],
        name = json["species"]["name"],
        weight = json["weight"].toDouble() / 10.0,
        height = json["height"].toDouble() * 10.0,
        typesList = getListTypesFromJson(json["types"]),
        abilitiesList = getListAbilitiesFromJson(json["abilities"]);

  static List<String> getListTypesFromJson(List<dynamic> json) {
    final List<String> typesList = [];
    for (var element in json) {
      typesList.add(element["type"]["name"]);
    }
    return typesList;
  }

  static List<String> getListAbilitiesFromJson(List<dynamic> json) {
    final List<String> abilitiesList = [];
    for (var element in json) {
      abilitiesList.add(element["ability"]["name"]);
    }
    return abilitiesList;
  }
}
