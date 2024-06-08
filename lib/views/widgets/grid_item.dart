import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Models/pokemon.dart';
import 'package:myapp/Models/pokemon_list_item.dart';
import 'package:myapp/Utils/capitalize.dart';
import 'package:myapp/Utils/palette.dart';
import 'package:myapp/Utils/pokemon_api.dart';
import 'package:myapp/Utils/pokemon_type_color.dart';
import 'package:flutter_svg/svg.dart';
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
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: pokemonColor,
                  borderRadius: BorderRadius.circular(16.r)),
              child: Stack(children: [
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
                      const SizedBox(
                        height: 4 ,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: typesList(pokemon!),
                          ),
                          SizedBox(
                            height: 56.r,
                            width: 56.r,
                            child: Image.network(
                              pokemon!.urlSprite,
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ]),
            ),
          );
  }

  List<Widget> typesList(Pokemon pokemon) {
    List<Widget> typesList = [];
    for (var i = 0; i < pokemon.typesList.length; i++) {
      if (i >= 1) {
        typesList.add(const SizedBox(
          height: 4 ,
        ));
      }
      typesList.add(
        Container(
          decoration: BoxDecoration(
            color: gray[500]?.withOpacity(0.2),
            borderRadius: BorderRadius.circular(24.r),
          ),
          padding:
              EdgeInsets.only(left: 2.w, top: 2 , bottom: 2 , right: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                    "assets/types_icons/Pokémon_${pokemon.typesList[i].capitalize()}_Type_Icon.png"),
                height: 15.r,
                width: 15.r,
              ),
              SizedBox(
                width: 4.w,
              ),
              StyledText(
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Colors.white),
                textHeight: 16 ,
                text: pokemon.typesList[i].capitalize(),
              )
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
              .copyWith(color: Colors.white),
          text: pokemon?.name.capitalize(),
          textHeight: 16 ,
        ),
        StyledText(
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
              ),
          text: "#${pokemon?.id.toString().padLeft(3, "0")}",
          textHeight: 16 ,
        ),
      ],
    );
  }
}