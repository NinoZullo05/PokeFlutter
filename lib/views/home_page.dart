import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Models/pokemon_list_item.dart';
import 'package:myapp/Utils/palette.dart';
import 'package:myapp/views/widgets/search_bar.dart';
import 'package:myapp/views/widgets/top_text.dart';
import 'widgets/pokemon_list.dart';
import 'widgets/random_floating_button.dart';
import 'widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<PokemonListItem> pokemonList = [];
  final List<PokemonListItem> filteredPokemonList = [];
  final TextEditingController searchController = TextEditingController();

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
    if (searchController.text.isNotEmpty) {
      searchPokemon(searchController.text);
    }
  }

  void searchPokemon(String query) {
    setState(() {
      filteredPokemonList.clear();
      if (query.isNotEmpty) {
        final filtered = pokemonList.where((pokemon) {
          return pokemon.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
        filteredPokemonList.addAll(filtered);
      } else {
        filteredPokemonList.addAll(pokemonList);
      }
    });
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
            SizedBox(
              height: 16.h,
            ),
            SearchBarF(
              searchController: searchController,
            ),
            SizedBox(
              height: 16.h,
            ),
            PokemonList(
              pokemonList: filteredPokemonList,
            ),
          ],
        ),
      ),
    );
  }
}
