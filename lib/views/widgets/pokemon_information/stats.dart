import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Models/pokemon.dart';
import 'package:myapp/Utils/palette.dart';

class StatsPokemon extends StatefulWidget {
  final Pokemon pokemon;

  const StatsPokemon({super.key, required this.pokemon});

  @override
  State<StatsPokemon> createState() => _StatsPokemonState();
}

class _StatsPokemonState extends State<StatsPokemon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatsList(context, "HP", widget.pokemon.hp),
              _buildStatsList(context, "Attack", widget.pokemon.attack),
              _buildStatsList(context, "Defense", widget.pokemon.defense),
              _buildStatsList(context, "Sp. Atk", widget.pokemon.specialAttack),
              _buildStatsList(
                  context, "Sp. Def", widget.pokemon.specialDefense),
              _buildStatsList(context, "Speed", widget.pokemon.speed),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsList(BuildContext context, String text, int num) {
    int yellowDot = (num / 10).floor();
    if (yellowDot > 15) yellowDot = 15;
    int grayDot = 15 - yellowDot;

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
                color: gray[500],
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const Spacer(),
          SizedBox(width: 16.w),
          Row(
            children: List.generate(yellowDot, (index) {
              return Container(
                height: 24.h,
                width: 8.w,
                margin: EdgeInsets.symmetric(horizontal: 2.5.w),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              );
            }),
          ),
          Row(
            children: List.generate(grayDot, (index) {
              return Container(
                height: 24.h,
                width: 8.w,
                margin: EdgeInsets.symmetric(horizontal: 2.5.w),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
