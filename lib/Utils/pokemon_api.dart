import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchPokemon(String name) async {
  final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$name'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load pokemon');
  }
}
