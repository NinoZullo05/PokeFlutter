import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Models/pokemon.dart';
import 'package:myapp/Models/pokemon_list_item.dart';
import 'package:myapp/Utils/capitalize.dart';
import 'package:myapp/Utils/palette.dart';
import 'package:myapp/Utils/pokemon_api.dart';
import 'package:myapp/Utils/pokemon_type_color.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/views/widgets/pokemon_information.dart';
import 'package:myapp/views/widgets/top_text.dart';

class GridItem extends StatefulWidget {
  final PokemonListItem pokemon;
  const GridItem({super.key, required this.pokemon});

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  Pokemon? pokemon;
  bool _isLoading = true;
  Color? pokemonColor;

  @override
  void initState() {
    fetchPokemonData();
    super.initState();
  }

  void fetchPokemonData() async {
    pokemon = await PokemonApi.getPokemonDetails(widget.pokemon.name);
    pokemonColor = listPokemonTypeColor[pokemon?.typesList[0].toLowerCase()];
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonInformation(pokemon: pokemon!),
                ),
              );
            },
            child: Container(
              height: 500.r,
              decoration: BoxDecoration(
                color: pokemonColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: -20.r,
                    right: -11.r,
                    child: SvgPicture.asset(
                      "assets/pokeball.svg",
                      height: 88.r,
                      width: 88.r,
                      color: Colors.white12,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _header(context),
                        SizedBox(height: 4.h),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: typesList(pokemon!),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        height: 50.r,
                                        width: 50.r,
                                        child: Image.network(
                                          pokemon!.urlSprite,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  List<Widget> typesList(Pokemon pokemon) {
    List<Widget> typesList = [];

    for (var i = 0; i < pokemon.typesList.length; i++) {
      if (i >= 1) {
        typesList.add(SizedBox(
            height: 3.h)); 
      }

      typesList.add(
        Container(
          decoration: BoxDecoration(
            color: gray[500]?.withOpacity(0.2),
            borderRadius: BorderRadius.circular(24.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  "assets/types_icons/Pokémon_${pokemon.typesList[i].capitalize()}_Type_Icon.png",
                ),
                height: 12.r, 
                width: 12.r,
              ),
              SizedBox(width: 3.w),
              Flexible(
                child: Text(
                  pokemon.typesList[i].capitalize(),
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.white,
                        fontSize: 10.sp, 
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return typesList;
  }

  Row _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StyledText(
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white, fontSize: 16.sp),
          text: pokemon?.name.capitalize(),
          textHeight: 16,
        ),
        StyledText(
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white, fontSize: 12.sp),
          text: "#${pokemon?.id.toString().padLeft(3, "0")}",
          textHeight: 16,
        ),
      ],
    );
  }
}
