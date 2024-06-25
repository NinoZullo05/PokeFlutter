import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Utils/capitalize.dart';
import 'package:myapp/Utils/palette.dart';

class CompareResultPage extends StatelessWidget {
  final Map<String, dynamic> pokemon1;
  final Map<String, dynamic> pokemon2;

  CompareResultPage({
    Key? key,
    required this.pokemon1,
    required this.pokemon2,
  }) : super(key: key);

  // Method to calculate the total stats of a Pokémon
  int calculateTotalStats(Map<String, dynamic> pokemon) {
    int totalStats = 0;
    for (var stat in pokemon['stats']) {
      totalStats += (stat['base_stat'] as int);
    }
    return totalStats;
  }

  Map<String, dynamic> pokemonWinner = {};
  Map<String, dynamic> pokemonLoser = {};

  void determineWinner() {
    int totalStats1 = calculateTotalStats(pokemon1);
    int totalStats2 = calculateTotalStats(pokemon2);

    if (totalStats1 > totalStats2) {
      pokemonWinner = pokemon1;
      pokemonLoser = pokemon2;
    } else if (totalStats2 > totalStats1) {
      pokemonWinner = pokemon2;
      pokemonLoser = pokemon1;
    } else {
      pokemonWinner = {}; // Handle tie if needed
      pokemonLoser = {};
    }
  }

  Widget _buildStatsList(
      BuildContext context, String text, int num, int loserNum) {
    int yellowDot = (num / 10).floor();
    if (yellowDot > 15) yellowDot = 15;
    int grayDot = 15 - yellowDot;

    List<Widget> yellowWidgets = List.generate(yellowDot, (index) {
      return Container(
        height: 24.h,
        width: 8.w,
        margin: EdgeInsets.symmetric(horizontal: 2.5.w),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(5.r),
        ),
      );
    });

    List<Widget> grayWidgets = List.generate(grayDot, (index) {
      return Container(
        height: 24.h,
        width: 8.w,
        margin: EdgeInsets.symmetric(horizontal: 2.5.w),
        decoration: BoxDecoration(
          color: Colors.grey[500],
          borderRadius: BorderRadius.circular(5.r),
        ),
      );
    });

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      child: Row(
        children: [
          SizedBox(
            width: 64.w,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(
            width: 32.w,
            child: Text(
              "$num",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...yellowWidgets,
                  ...grayWidgets,
                ],
              ),
            ),
          ),
          SizedBox(
            width: 16.w,
            child: Text(
              "$loserNum",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    determineWinner();

    String winnerText = pokemonWinner.isNotEmpty
        ? "${pokemonWinner['name'].toString().capitalize()} wins!"
        : "It's a tie!";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Comparator"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: Column(
                          children: [
                            Image.network(
                              pokemonWinner['sprites']['front_default'],
                              height: 150.h,
                            ),
                            Text(pokemonWinner['name'].toString().capitalize()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: Column(
                          children: [
                            Image.network(
                              pokemonLoser['sprites']['front_default'],
                              height: 150.h,
                            ),
                            Text(pokemonLoser['name'].toString().capitalize()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                winnerText,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              _buildStatsList(
                context,
                "HP",
                pokemonWinner['stats'][0]['base_stat'],
                pokemonLoser['stats'][0]['base_stat'],
              ),
              _buildStatsList(
                context,
                "Attack",
                pokemonWinner['stats'][1]['base_stat'],
                pokemonLoser['stats'][1]['base_stat'],
              ),
              _buildStatsList(
                context,
                "Defense",
                pokemonWinner['stats'][2]['base_stat'],
                pokemonLoser['stats'][2]['base_stat'],
              ),
              _buildStatsList(
                context,
                "Sp. Atk",
                pokemonWinner['stats'][3]['base_stat'],
                pokemonLoser['stats'][3]['base_stat'],
              ),
              _buildStatsList(
                context,
                "Sp. Def",
                pokemonWinner['stats'][4]['base_stat'],
                pokemonLoser['stats'][4]['base_stat'],
              ),
              _buildStatsList(
                context,
                "Speed",
                pokemonWinner['stats'][5]['base_stat'],
                pokemonLoser['stats'][5]['base_stat'],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
