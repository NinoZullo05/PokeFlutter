import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GuessPokemon extends StatefulWidget {
  const GuessPokemon({Key? key}) : super(key: key);

  @override
  State<GuessPokemon> createState() => _GuessPokemonState();
}

class _GuessPokemonState extends State<GuessPokemon> {
  late String correctPokemonName;
  late List<String> options = [];
  late String spriteUrl =
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/unknown.png";

  @override
  void initState() {
    super.initState();
    fetchPokemon();
  }

  Future<void> fetchPokemon() async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon-species/?limit=151'));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final pokemonList = decoded['results'];
      final random = Random();
      final index = random.nextInt(pokemonList.length);
      correctPokemonName = pokemonList[index]['name'];
      options = generateOptions(correctPokemonName, pokemonList);
      fetchSprite(correctPokemonName);
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }

  List<String> generateOptions(String correctName, List<dynamic> pokemonList) {
    List<String> options = [];
    options.add(correctName);

    final random = Random();
    while (options.length < 3) {
      final index = random.nextInt(pokemonList.length);
      final pokemonName = pokemonList[index]['name'];
      if (pokemonName != correctName && !options.contains(pokemonName)) {
        options.add(pokemonName);
      }
    }

    // Shuffle options array
    options.shuffle();
    return options;
  }

  Future<void> fetchSprite(String pokemonName) async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final spriteUrl = decoded['sprites']['front_default'];
      setState(() {
        this.spriteUrl = spriteUrl;
      });
    } else {
      throw Exception('Failed to load Pokemon sprite');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess the Pokemon'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              spriteUrl,
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text('Which Pokemon is this?'),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: options
                  .map(
                    (option) => ElevatedButton(
                      onPressed: () {
                        if (option == correctPokemonName) {
                          // Correct guess logic
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Correct!'),
                                content: Text('You guessed it right!'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      fetchPokemon(); // Load new Pokemon
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Incorrect guess logic (can be added if needed)
                        }
                      },
                      child: Text(option),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
