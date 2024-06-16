import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Models/pokemon.dart';
import 'package:myapp/Utils/palette.dart';
import 'package:myapp/views/widgets/pokemon_information/about.dart';
import 'package:myapp/views/widgets/pokemon_information/moves.dart';
import 'package:myapp/views/widgets/pokemon_information/stats.dart';

class PokemonDetails extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetails({super.key, required this.pokemon});

  @override
  _PokemonDetailsState createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(360, 690), minTextAdapt: true);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSectionTitle("About", Icons.info, 0, constraints),
                    _buildSectionTitle(
                        "Stats", Icons.bar_chart, 1, constraints),
                    _buildSectionTitle(
                        "Moves", Icons.sports_mma, 2, constraints),
                    _buildSectionTitle(
                        "Evolutions", Icons.autorenew, 3, constraints),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  children: [
                    _buildAboutSection(),
                    _buildStatsSection(),
                    _buildMovesSection(),
                    _buildEvolutionsSection(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(
      String title, IconData icon, int pageIndex, BoxConstraints constraints) {
    bool isSelected = _currentPageIndex == pageIndex;
    bool useIcon = constraints.maxWidth < 360;

    double fontSize = constraints.maxWidth < 360 ? 12.sp : 14.sp;
    double iconSize = constraints.maxWidth < 360 ? 20.sp : 24.sp;
    double paddingHorizontal = constraints.maxWidth < 360 ? 8.w : 16.w;

    return InkWell(
      onTap: () {
        _pageController.animateToPage(
          pageIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 8.h),
        child: Column(
          children: [
            useIcon
                ? Icon(
                    icon,
                    size: iconSize,
                    color: isSelected ? gray[500] : gray[300],
                  )
                : Text(
                    title,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? gray[500] : gray[300],
                    ),
                  ),
            SizedBox(height: 4.h),
            if (isSelected)
              Container(
                height: 2.0,
                width: 30.0,
                decoration: BoxDecoration(
                  color: gray[400],
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Center(
      child: AboutPokemon(pokemon: widget.pokemon),
    );
  }

  Widget _buildStatsSection() {
    return Center(child: StatsPokemon(pokemon: widget.pokemon));
  }

  Widget _buildMovesSection() {
    return Center(child: MovesPokemon(pokemon: widget.pokemon),);
  }

  Widget _buildEvolutionsSection() {
    return const Center(child: Text("Evolutions Section"));
  }
}
