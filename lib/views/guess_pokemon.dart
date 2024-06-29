import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class GuessPokemon extends StatefulWidget {
  const GuessPokemon({super.key});

  @override
  State<GuessPokemon> createState() => _GuessPokemonState();
}

class _GuessPokemonState extends State<GuessPokemon> {
  String? _pokemonSprite;
  String? _pokemonName;
  bool _isLoading = true;
  bool _showConfetti = false;
  List<String> _pokemonOptions = [];
  final random = Random();
  String? _selectedOption;
  bool? _isCorrect;

  @override
  void initState() {
    super.initState();
    _fetchRandomPokemon();
  }

  Future<void> _fetchRandomPokemon() async {
    final pokemonId = random.nextInt(898) + 1;
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final sprite = data['sprites']['front_default'];
      final name = data['name'];

      setState(() {
        _pokemonSprite = sprite;
        _pokemonName = name;
        _isLoading = false;
      });

      _generatePokemonOptions(name);
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load Pokémon');
    }
  }

  Future<void> _generatePokemonOptions(String correctName) async {
    Set<String> options = {correctName};

    while (options.length < 3) {
      final pokemonId = random.nextInt(898) + 1;
      final response = await http
          .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        options.add(data['name']);
      }
    }

    setState(() {
      _pokemonOptions = options.toList()..shuffle();
      _isLoading = false;
    });
  }

  void _checkAnswer(String selectedName) {
    final isCorrect = selectedName == _pokemonName;
    setState(() {
      _selectedOption = selectedName;
      _isCorrect = isCorrect;
      _showConfetti = isCorrect;
    });
  }

  void _resetGame() {
    setState(() {
      _isLoading = true;
      _showConfetti = false;
      _selectedOption = null;
      _isCorrect = null;
      _pokemonSprite = null;
      _pokemonOptions = [];
    });
    _fetchRandomPokemon();
  }

  Widget _buildPokemonImage() {
    if (_isLoading) {
      return const CircularProgressIndicator();
    }
    if (_pokemonSprite != null) {
      return Stack(
        alignment: Alignment.center,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                _selectedOption != null && _isCorrect == true
                    ? Colors.transparent
                    : Colors.black,
                BlendMode.srcIn),
            child: Image.network(
              _pokemonSprite!,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.65,
            ),
          ),
          if (_showConfetti)
            Positioned.fill(
              child: Image.asset(
                'assets/confetti.png',
                fit: BoxFit.cover,
              ),
            ),
          if (_showConfetti)
            Image.network(
              _pokemonSprite!,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.65,
            ),
        ],
      );
    } else {
      return const Text('Failed to load Pokémon');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Who’s that Pokémon!",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPokemonImage(),
            if (!_isLoading && _pokemonOptions.isNotEmpty) ...[
              SizedBox(height: 20.h),
              ..._pokemonOptions.map((name) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.h),
                  child: InkWell(
                    onTap: () => _checkAnswer(name),
                    child: Container(
                      padding: EdgeInsets.all(12.0.sp),
                      decoration: BoxDecoration(
                        color: _selectedOption == name
                            ? (_isCorrect == true ? Colors.yellow : Colors.red)
                            : Colors.transparent,
                        border: Border.all(
                          color: Colors.grey[300]!,
                        ),
                        borderRadius: BorderRadius.circular(8.0.sp),
                      ),
                      child: Center(
                        child: Text(
                          name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: 20.h),
              if (_selectedOption != null)
                InkWell(
                  onTap: _resetGame,
                  child: Container(
                    padding: EdgeInsets.all(12.0.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.cached),
                        SizedBox(width: 5.w),
                        Text(
                          "Again",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
