import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Database/database_helper.dart';
import 'package:myapp/Models/favourite_pokemon.dart';
import 'package:myapp/Models/pokemon_list_item.dart';
import 'widgets/pokemon_list.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/top_text.dart';
import 'package:myapp/Utils/palette.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  late List<PokemonListItem> favoritePokemons = [];

  @override
  void initState() {
    super.initState();
    fetchFavoritePokemons();
  }

  void fetchFavoritePokemons() async {
    List<FavoritePokemon> favorites =
        await DatabaseHelper().getAllFavoritePokemon();
    setState(() {
      favoritePokemons = favorites
          .map((fav) => PokemonListItem(name: fav.name, url: fav.imageUrl))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(24.w, 76.h, 24.w, 0),
              child: StyledText(
                text: "Favorites",
                style: textTheme.displaySmall!.copyWith(
                  fontSize: 44.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: Text(
                "This is the list of your favourite Pokémon! Favorite numbers: ${favoritePokemons.length}",
                style: textTheme.bodyLarge!.copyWith(
                  color: gray[400],
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            PokemonList(pokemonList: favoritePokemons),
          ],
        ),
      ),
    );
  }
}
