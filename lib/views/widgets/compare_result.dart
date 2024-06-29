import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Utils/capitalize.dart';
import 'package:myapp/Utils/palette.dart';

class CompareResultPage extends StatelessWidget {
  final Map<String, dynamic> pokemon1;
  final Map<String, dynamic> pokemon2;

  CompareResultPage({
    super.key,
    required this.pokemon1,
    required this.pokemon2,
  });

  int calculateTotalStats(Map<String, dynamic> pokemon) {
    int totalStats = 0;
    for (var stat in pokemon['stats']) {
      totalStats += (stat['base_stat'] as int);
    }
    return totalStats;
  }

  Map<String, dynamic> pokemonWinner = {};
  Map<String, dynamic> pokemonLoser = {};

  bool isTie = false;

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
      isTie = true;
      pokemonWinner = pokemon1;
      pokemonLoser = pokemon2;
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
        width: 7.w,
        margin: EdgeInsets.symmetric(horizontal: 1.w),
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
        margin: EdgeInsets.symmetric(horizontal: 1.w),
        decoration: BoxDecoration(
          color: gray[500],
          borderRadius: BorderRadius.circular(5.r),
        ),
      );
    });

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 5.w),
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
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: gray[500]),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  ...yellowWidgets,
                  ...grayWidgets,
                ],
              ),
            ),
          ),
          SizedBox(
            child: Text(
              "$loserNum",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: gray[500]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    determineWinner();

    String winnerText = isTie
        ? "It's a tie!"
        : "${pokemonWinner['name'].toString().capitalize()} wins!";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comparator",
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
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Image.network(
                              pokemonWinner['sprites']['front_default'],
                              height: 150.h,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            pokemonWinner['name'].toString().capitalize(),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: gray[500],
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Image.network(
                              pokemonLoser['sprites']['front_default'],
                              height: 150.h,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            pokemonLoser['name'].toString().capitalize(),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: gray[500],
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                winnerText,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: gray[500],
                    ),
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
