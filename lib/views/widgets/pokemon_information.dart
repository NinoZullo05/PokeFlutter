import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Models/pokemon.dart';
import 'package:myapp/Utils/capitalize.dart';
import 'package:myapp/Utils/pokemon_type_color.dart';
import 'package:myapp/views/widgets/pokemon_information/pokemon_details.dart';

class PokemonInformation extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonInformation({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        listPokemonTypeColor[pokemon.typesList[0].toLowerCase()] ?? Colors.grey;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          _displayNumber(pokemon.id).toString(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  backgroundColor,
                  backgroundColor.withOpacity(0.75),
                  backgroundColor.withOpacity(0.5),
                  backgroundColor.withOpacity(0.25),
                  Colors.white,
                ],
                stops: const [
                  0.0,
                  0.1,
                  0.2,
                  0.3,
                  1.0,
                ],
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Image.network(
                    pokemon.urlSprite,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20.h),
                  Text(pokemon.name.capitalize(),
                      style: Theme.of(context).textTheme.titleLarge!),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
          Expanded(
            child: PokemonDetails(pokemon: pokemon),
          ),
        ],
      ),
    );
  }
}

String _displayNumber(int number) {
  if (number < 10) {
    return "#00$number";
  } else if (number < 100) {
    return "#0$number";
  } else {
    return "#${number.toString()}";
  }
}
