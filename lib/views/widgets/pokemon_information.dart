import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Database/database_helper.dart';
import 'package:myapp/Models/favourite_pokemon.dart';
import 'package:myapp/Models/pokemon.dart';
import 'package:myapp/Utils/capitalize.dart';
import 'package:myapp/Utils/pokemon_type_color.dart';
import 'package:myapp/views/widgets/pokemon_information/pokemon_details.dart';

class PokemonInformation extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonInformation({Key? key, required this.pokemon}) : super(key: key);

  @override
  _PokemonInformationState createState() => _PokemonInformationState();
}

class _PokemonInformationState extends State<PokemonInformation> {
  bool isFavorite = false; 
  late DatabaseHelper dbHelper; 

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    checkFavoriteStatus();
  }

  void checkFavoriteStatus() async {
    List<FavoritePokemon> favorites = await dbHelper.getAllFavoritePokemon();
    setState(() {
      isFavorite = favorites.any((element) => element.id == widget.pokemon.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        listPokemonTypeColor[widget.pokemon.typesList[0].toLowerCase()] ?? Colors.grey;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          _displayNumber(widget.pokemon.id).toString(),
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
            onPressed: () {
              toggleFavorite();
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
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
                    widget.pokemon.urlSprite,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    widget.pokemon.name.capitalize(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
          Expanded(
            child: PokemonDetails(pokemon: widget.pokemon),
          ),
        ],
      ),
    );
  }

  void toggleFavorite() async {
    if (isFavorite) {
      await dbHelper.deletePokemon(widget.pokemon.id);
    } else {
      await dbHelper.insertPokemon(FavoritePokemon(
        id: widget.pokemon.id,
        name: widget.pokemon.name,
        imageUrl: widget.pokemon.urlSprite,
      ));
    }
    
    setState(() {
      isFavorite = !isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? '${widget.pokemon.name.capitalize()} aggiunto ai preferiti.'
              : '${widget.pokemon.name.capitalize()} rimosso dai preferiti.',
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }

  String _displayNumber(int number) {
    if (number < 10) {
      return "#00$number";
    } else if (number < 100) {
      return "#0$number";
    } else {
      return "#$number";
    }
  }
}
