import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Models/pokemon_list_item.dart';
import 'grid_item.dart';

class PokemonList extends StatelessWidget {
  final List<PokemonListItem> pokemonList;
  const PokemonList({super.key, required this.pokemonList});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      height: deviceSize.height * 0.55,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: GridView.builder(
        itemCount: pokemonList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.r,
          mainAxisSpacing: 8.r,
          mainAxisExtent: deviceSize.height * 0.128,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GridItem(pokemon: pokemonList[index]);
        },
      ),
    );
  }
}
