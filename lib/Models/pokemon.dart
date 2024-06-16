import 'dart:convert';
import 'package:http/http.dart' as http;

class Pokemon {
  final int id;
  final String name;
  final String urlSprite;
  final String urlImage;
  final double weight;
  final double height;
  final List<String> typesList;
  final List<String> abilitiesList;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;
  final List<String> moves;
  final List<String> evolutions;

  Pokemon({
    required this.id,
    required this.name,
    required this.urlSprite,
    required this.urlImage,
    required this.weight,
    required this.height,
    required this.typesList,
    required this.abilitiesList,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
    required this.moves,
    required this.evolutions,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<String> abilitiesList = getListAbilitiesFromJson(json['abilities']);
    List<String> typesList = getListTypesFromJson(json['types']);

    int hp = json['stats'][0]['base_stat'];
    int attack = json['stats'][1]['base_stat'];
    int defense = json['stats'][2]['base_stat'];
    int specialAttack = json['stats'][3]['base_stat'];
    int specialDefense = json['stats'][4]['base_stat'];
    int speed = json['stats'][5]['base_stat'];

    List<String> moves = [];
    json['moves'].forEach((move) {
      moves.add(move['move']['name']);
    });

    List<String> evolutions = [];
    return Pokemon(
      id: json['id'],
      name: json['species']['name'],
      urlSprite: json['sprites']['front_default'],
      urlImage: json['sprites']['other']['official-artwork']['front_default'],
      weight: json['weight'].toDouble() / 10.0,
      height: json['height'].toDouble() * 10.0,
      typesList: typesList,
      abilitiesList: abilitiesList,
      hp: hp,
      attack: attack,
      defense: defense,
      specialAttack: specialAttack,
      specialDefense: specialDefense,
      speed: speed,
      moves: moves,
      evolutions: evolutions,
    );
  }

  static List<String> getListTypesFromJson(List<dynamic> json) {
    final List<String> typesList = [];
    for (var element in json) {
      typesList.add(element['type']['name']);
    }
    return typesList;
  }

  static List<String> getListAbilitiesFromJson(List<dynamic> json) {
    final List<String> abilitiesList = [];
    for (var element in json) {
      abilitiesList.add(element['ability']['name']);
    }
    return abilitiesList;
  }
}

Future<Pokemon> fetchPokemon(int id) async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
  if (response.statusCode == 200) {
    return Pokemon.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Pokemon');
  }
}
