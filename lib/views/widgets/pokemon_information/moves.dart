import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Models/pokemon.dart';
import 'package:myapp/Utils/capitalize.dart';

class MovesPokemon extends StatefulWidget {
  final Pokemon pokemon;
  const MovesPokemon({super.key, required this.pokemon});

  @override
  State<MovesPokemon> createState() => _MovesPokemonState();
}

class _MovesPokemonState extends State<MovesPokemon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: widget.pokemon.moves.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return _buildMove(widget.pokemon.moves[index]);
        },
      ),
    );
  }

  Widget _buildMove(String move) {
    return Row(
      children: [
        Text(move.capitalize(), style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
