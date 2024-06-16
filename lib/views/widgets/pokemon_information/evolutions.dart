import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Models/evolution.dart';
import 'package:myapp/Models/pokemon.dart';
import 'package:myapp/Utils/capitalize.dart';
import 'package:myapp/Utils/palette.dart';


class EvolutionsTab extends StatefulWidget {
  final int pokemonId;

  EvolutionsTab({Key? key, required this.pokemonId}) : super(key: key);

  @override
  State<EvolutionsTab> createState() => _EvolutionsTabState();
}

class _EvolutionsTabState extends State<EvolutionsTab> {
  late Future<List<Evolution>> _futureEvolutions;

  @override
  void initState() {
    super.initState();
    _futureEvolutions = fetchPokemonEvolutions(widget.pokemonId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Evolution>>(
        future: _futureEvolutions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No evolutions found.'));
          } else {
            List<Evolution> evolutions = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: evolutions.asMap().entries.map((entry) {
                  int idx = entry.key;
                  Evolution evolution = entry.value;
                  return Column(
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 44),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: gray[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              // Pokémon image
                              Image.network(
                                evolution.spriteUrl,
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Name: ${evolution.name}',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  Text(
                                    'ID: ${evolution.id}',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  Row(
                                    children: evolution.types.map((type) {
                                      String typeName =
                                          type.toLowerCase().capitalize();
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Image(
                                          image: AssetImage(
                                            "assets/types_icons/Pokémon_${typeName}_Type_Icon.png",
                                          ),
                                          height: 38,
                                          width: 38,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (idx < evolutions.length - 1)
                        Container(
                          width: double.infinity,
                          height: 48,
                          child: Center(
                            child: Container(
                              width: 2,
                              height: 48,
                              color: gray[200],
                            ),
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

