import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Models/pokemon.dart';
import 'package:myapp/Utils/palette.dart';

import 'package:myapp/views/widgets/pokemon_information/about.dart';

class PokemonDetails extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetails({Key? key, required this.pokemon}) : super(key: key);

  @override
  _PokemonDetailsState createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSectionTitle("About", 0),
                _buildSectionTitle("Stats", 1),
                _buildSectionTitle("Moves", 2),
                _buildSectionTitle("Evolutions", 3),
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
      ),
    );
  }

  Widget _buildSectionTitle(String title, int pageIndex) {
    return InkWell(
      onTap: () {
        _pageController.animateToPage(
          pageIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: _currentPageIndex == pageIndex ? FontWeight.bold : FontWeight.normal,
            color: _currentPageIndex == pageIndex ? gray[500] : gray[300],
          ),
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
    return const Center(child: Text("Stats Section"));
  }

  Widget _buildMovesSection() {
    return const Center(child: Text("Moves Section"));
  }

  Widget _buildEvolutionsSection() {
    return const Center(child: Text("Evolutions Section"));
  }
}
