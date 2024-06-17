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
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 44),
                        child: Row(
                          children: [
                            // Pokémon image container with gray background
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: gray[100],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  evolution.spriteUrl,
                                  width: 80.w,
                                  height: 80.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_displayNumber(evolution.id),
                                      style: Theme.of(context).textTheme.bodyLarge),
                                  Text(evolution.name.capitalize(),
                                      style: Theme.of(context).textTheme.labelLarge),
                                  SizedBox(height: 8.h),
                                  Wrap(
                                    spacing: 4.w,
                                    runSpacing: 4.h,
                                    children: evolution.types.map((type) {
                                      String typeName = type.toLowerCase().capitalize();
                                      return Container(
                                        height: 30.h,
                                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                "assets/types_icons/Pokémon_${typeName}_Type_Icon.png",
                                              ),
                                              height: 20.h,
                                              width: 20.w,
                                            ),
                                            SizedBox(width: 4.w),
                                            Text(typeName, style: TextStyle(fontSize: 12.sp)),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
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

String _displayNumber(int number) {
  if (number < 10) {
    return "#00$number";
  } else if (number < 100) {
    return "#0$number";
  } else {
    return "#${number.toString()}";
  }
}
