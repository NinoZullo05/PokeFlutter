import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:myapp/Utils/capitalize.dart';
import 'package:myapp/Utils/palette.dart';
import 'package:myapp/views/compare_result.dart';
import 'package:myapp/views/widgets/bottom_nav_bar.dart';
import 'package:myapp/views/widgets/compare_button.dart';
import 'package:myapp/views/widgets/top_text.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({Key? key}) : super(key: key);

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
  int _selectedIndex = 1;

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
          pokemons.add(jsonDecode(pokemonData.body));
        }
      }
      return pokemons;
    } else {
      throw Exception('Failed to load Pokemons');
    }
  }

  void searchPokemon(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPokemonList = [];
      } else {
        filteredPokemonList = pokemonList.where((pokemon) {
          return pokemon['name'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void showPokemonSelector(bool isFirst) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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
                      setState(() {
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
                            : ListView.builder(
                                itemCount: filteredPokemonList.length,
                                itemBuilder: (context, index) {
                                  final pokemon = filteredPokemonList[index];
                                  return ListTile(
                                    leading: Image.network(
                                        pokemon['sprites']['front_default']),
                                    title: Text(
                                      "${pokemon['name']}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (isFirst) {
                                          selectedPokemon1 = pokemon;
                                        } else {
                                          selectedPokemon2 = pokemon;
                                        }
                                        isReadyToCompare =
                                            selectedPokemon1 != null &&
                                                selectedPokemon2 != null;
                                      });
                                      Navigator.pop(context);
                                    },
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 64.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: StyledText(
                  text: "Comparator",
                  style: textTheme.labelLarge!,
                  textHeight: 44.sp,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "Select two Pokémon and compare them to see who is the strongest!",
                style: textTheme.labelLarge
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
                      // First Pokemon Selector
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
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                  ),
                                  color: Colors.white,
                                ),
                                width: MediaQuery.of(context).size.width * 0.35,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                              ),
                              selectedPokemon1 != null
                                  ? Image.network(selectedPokemon1!['sprites']
                                      ['front_default'])
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      // Second Pokemon Selector
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
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                  ),
                                  color: Colors.white,
                                ),
                                width: MediaQuery.of(context).size.width * 0.35,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                              ),
                              selectedPokemon2 != null
                                  ? Image.network(selectedPokemon2!['sprites']
                                      ['front_default'])
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Icon Positioned
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
