import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Models/evolution.dart';
import 'package:myapp/Models/pokemon.dart';
import 'package:myapp/Utils/capitalize.dart';

class EvolutionsTab extends StatefulWidget {
  final int pokemonId;

  const EvolutionsTab({super.key, required this.pokemonId});

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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No evolutions found.'));
          } else {
            List<Evolution> evolutions = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: evolutions.asMap().entries.map((entry) {
                  int idx = entry.key;
                  Evolution evolution = entry.value;
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        child: Row(
                          children: [
                            Container(
                              height: 96.h,
                              width: 140.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey[200],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  evolution.spriteUrl,
                                  width: 64.w,
                                  height: 64.h,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  Text(evolution.name.capitalize(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge),
                                  SizedBox(height: 8.h),
                                  Wrap(
                                    spacing: 4.w,
                                    runSpacing: 4.h,
                                    children: evolution.types.map((type) {
                                      String typeName =
                                          type.toLowerCase().capitalize();
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w, vertical: 4.h),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.orange.withOpacity(0.2),
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
                                            Text(typeName,
                                                style: TextStyle(fontSize: 12.sp)),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                        ),
                      ),
                      if (idx < evolutions.length - 1)
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                            ),
                            Container(
                              width: 2,
                              height: 48,
                              color: Colors.grey[300],
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Level ${evolutions[idx + 1].minLevel}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
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