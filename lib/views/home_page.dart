import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Models/pokemon_list_item.dart';
import 'package:myapp/Utils/palette.dart';
import 'package:myapp/views/widgets/bottom_nav_bar.dart';
import 'package:myapp/views/widgets/pokemon_list.dart';
import 'package:myapp/views/widgets/random_floating_button.dart';
import 'package:myapp/views/widgets/search_bar.dart';
import 'package:myapp/views/widgets/top_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<PokemonListItem> pokemonList = [];
  List<PokemonListItem> filteredPokemonList = [];
  final TextEditingController searchController = TextEditingController();
  List<int> selectedGenerations =
      []; // Lista per memorizzare gli ID delle generazioni selezionate

  @override
  void initState() {
    super.initState();
    readJsonFile();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void readJsonFile() async {
    final jsonFile = await rootBundle.loadString("assets/pokemon_list.json");
    final decoded = jsonDecode(jsonFile);
    for (var item in decoded["pokemonList"]) {
      final pokemonListItem =
          PokemonListItem(name: item["name"], url: item["url"]);
      pokemonList.add(pokemonListItem);
    }
    setState(() {
      filteredPokemonList.addAll(pokemonList);
    });
  }

  void _onSearchChanged() {
    filterPokemonList();
  }

  void filterPokemonList() {
    setState(() {
      filteredPokemonList = pokemonList.where((pokemon) {
        // Filtra per nome
        final nameMatches = pokemon.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase());
        // Filtra per generazioni selezionate
        final generationMatches = selectedGenerations.isEmpty ||
            selectedGenerations.contains(getGenerationId(pokemon.url));
        return nameMatches && generationMatches;
      }).toList();
    });
  }

  int getGenerationId(String url) {
    // Esempio di come ottenere l'ID di generazione dalla URL
    // Supponiamo che la URL sia nella forma "https://pokeapi.co/api/v2/pokemon-species/1/"
    // e vogliamo ottenere l'ID di generazione (1 in questo caso)
    final regex = RegExp(r"/api/v2/pokemon-species/(\d+)/$");
    final match = regex.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      final generationId = int.parse(match.group(1)!);
      // Implementa la logica per mappare l'ID della generazione in base ai tuoi requisiti
      // Ad esempio:
      // 1-151 -> Generazione 1
      // 152-251 -> Generazione 2
      // ...
      // 810-898 -> Generazione 8
      if (generationId >= 1 && generationId <= 151) {
        return 1; // Generazione 1
      } else if (generationId >= 152 && generationId <= 251) {
        return 2; // Generazione 2
      } else if (generationId >= 252 && generationId <= 386) {
        return 3; // Generazione 3
      }
      // Aggiungi altri controlli per le altre generazioni secondo necessità
    }
    return 0; // Ritorna 0 o un valore di default se non riesce a estrarre l'ID della generazione
  }

  void handleGenerationSelected(int index) {
    setState(() {
      final generationId = index + 1; 
      if (selectedGenerations.contains(generationId)) {
        selectedGenerations.remove(generationId);
      } else {
        selectedGenerations.add(generationId);
      }
    });
    filterPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      floatingActionButton: const RandomFloatingButton(),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 76.h, left: 24.w, right: 24.w),
              child: StyledText(
                text: "Pokédex",
                style: textTheme.displaySmall!,
                textHeight: 44,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Use the advanced search to find Pokémon by type, weakness, ability and more!",
                style: textTheme.bodyLarge
                    ?.copyWith(color: gray[400], height: (24 / 16)),
              ),
            ),
            SizedBox(height: 16.h),
            SearchBarF(
              searchController: searchController,
            ),
            SizedBox(height: 16.h),
            // Mostra le generazioni selezionate
            selectedGenerations.isEmpty
                ? const SizedBox.shrink()
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Wrap(
                      spacing: 8.w,
                      children: selectedGenerations
                          .map((generationId) => Chip(
                                label: Text('Generation $generationId'),
                                onDeleted: () {
                                  setState(() {
                                    selectedGenerations.remove(generationId);
                                    filterPokemonList(); // Aggiorna la lista filtrata dopo la rimozione
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ),
            SizedBox(height: 16.h),
            PokemonList(
              pokemonList: filteredPokemonList,
            ),
          ],
        ),
      ),
    );
  }
}
