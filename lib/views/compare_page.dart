import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Models/pokemon.dart';
import 'package:myapp/Models/pokemon_list_item.dart';
import 'dart:convert';

import 'package:myapp/Utils/palette.dart';
import 'package:myapp/views/widgets/compare_result.dart';
import 'package:myapp/views/widgets/bottom_nav_bar.dart';
import 'package:myapp/views/widgets/compare_button.dart';
import 'package:myapp/views/widgets/grid_item_compare.dart';
import 'package:myapp/views/widgets/top_text.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({super.key});

  @override
  State<ComparePage> createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  bool isReadyToCompare = false;
  Map<String, dynamic>? selectedPokemon1;
  Map<String, dynamic>? selectedPokemon2;
  List<Map<String, dynamic>> pokemonList = [];
  List<Map<String, dynamic>> filteredPokemonList = [];
  bool isLoading = true;
  String searchText = '';
  final int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    fetchPokemons().then((pokemons) {
      setState(() {
        pokemonList = pokemons;
        filteredPokemonList = pokemons;
        isLoading = false;
      });
    });
  }

  Future<List<Map<String, dynamic>>> fetchPokemons() async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=151'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];
      List<Map<String, dynamic>> pokemons = [];
      for (var result in results) {
        final pokemonData = await http.get(Uri.parse(result['url']));
        if (pokemonData.statusCode == 200) {
          final pokemonDetails = jsonDecode(pokemonData.body);
          pokemons.add(pokemonDetails);
        }
      }
      return pokemons;
    } else {
      throw Exception('Failed to load Pokemons');
    }
  }

  void searchPokemon(String query) {
    setState(() {
      filteredPokemonList = pokemonList.where((pokemon) {
        return pokemon['name'] != null &&
            pokemon['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void showPokemonSelector(bool isFirst) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Choose a Pokémon',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search a Pokémon',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      modalSetState(() {
                        searchText = value;
                        searchPokemon(value);
                      });
                    },
                  ),
                  Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : filteredPokemonList.isEmpty
                            ? Center(
                                child: Text(
                                  searchText.isEmpty
                                      ? "It seems that you have not yet chosen a Pokémon. Let's do it!"
                                      : 'No pokemon found',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              )
                            : GridView.builder(
                                itemCount: filteredPokemonList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1,
                                ),
                                itemBuilder: (context, index) {
                                  final pokemon = filteredPokemonList[index];
                                  return GridCompareItem(
                                    pokemon: PokemonListItem(
                                      name: pokemon['name'],
                                      url: pokemon['url'],
                                    ),
                                    onAddToCompare:
                                        addPokemonToCompare, // Passa la funzione di callback
                                  );
                                },
                              ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void comparePokemonStats() {
    if (selectedPokemon1 != null && selectedPokemon2 != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompareResultPage(
            pokemon1: selectedPokemon1!,
            pokemon2: selectedPokemon2!,
          ),
        ),
      );
    }
  }

  void addPokemonToCompare(Pokemon pokemon) {
    setState(() {
      if (selectedPokemon1 == null) {
        selectedPokemon1 = {
          'name': pokemon.name,
          'sprites': {'front_default': pokemon.urlSprite}
        };
      } else {
        selectedPokemon2 ??= {
          'name': pokemon.name,
          'sprites': {'front_default': pokemon.urlSprite}
        };
      }
      isReadyToCompare = selectedPokemon1 != null && selectedPokemon2 != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 64.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: StyledText(
                  text: "Comparator",
                  style: textTheme.displaySmall!,
                  textHeight: 44.sp,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "Select two Pokémon and compare them to see who is the strongest!",
                style: textTheme.bodyLarge
                    ?.copyWith(color: gray[400], height: (24 / 16)),
              ),
              SizedBox(
                height: 16.h,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.275,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: InkWell(
                          onTap: () => showPokemonSelector(true),
                          child: selectedPokemon1 != null
                              ? Image.network(
                                  selectedPokemon1!['sprites']['front_default'],
                                  fit: BoxFit.contain,
                                )
                              : Container(
                                  width: 150.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.r),
                                    border: Border.all(
                                      color: Colors.grey[200]!,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'ADD POKEMON',
                                      style: textTheme.labelLarge,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.275,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: InkWell(
                          onTap: () => showPokemonSelector(false),
                          child: selectedPokemon2 != null
                              ? Image.network(
                                  selectedPokemon2!['sprites']['front_default'],
                                  fit: BoxFit.contain,
                                )
                              : Container(
                                  width: 150.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.r),
                                    border: Border.all(
                                      color: Colors.grey[200]!,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'ADD POKEMON',
                                      style: textTheme.labelLarge,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.275 - 40.r,
                    child: Container(
                      alignment: Alignment.center,
                      width: 80.r,
                      height: 80.r,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.surface),
                      child: const Icon(Icons.casino_outlined,
                          size: 40, color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: CompareButton(
                  isReadyToCompare: isReadyToCompare,
                  onPressed: comparePokemonStats,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: _selectedIndex),
    );
  }
}
