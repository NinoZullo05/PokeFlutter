import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterPopupTypesAndWeaknesses extends StatefulWidget {
  const FilterPopupTypesAndWeaknesses({super.key});

  @override
  _FilterPopupTypesAndWeaknessesState createState() =>
      _FilterPopupTypesAndWeaknessesState();
}

class _FilterPopupTypesAndWeaknessesState
    extends State<FilterPopupTypesAndWeaknesses> {
  List<String> typesList = [
    "Bug",
    "Dark",
    "Dragon",
    "Electric",
    "Fairy",
    "Fighting",
    "Fire",
    "Flying",
    "Ghost",
    "Grass",
    "Ground",
    "Ice",
    "Normal",
    "Poison",
    "Psychic",
    "Rock",
    "Steel",
    "Water"
  ];
  List<bool> selectedTypes = List<bool>.filled(18, false);
  List<bool> selectedWeaknesses = List<bool>.filled(18, false);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Types",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(height: 16.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: typesList
                .asMap()
                .entries
                .map(
                  (entry) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTypes[entry.key] = !selectedTypes[entry.key];
                      });
                    },
                    child: Container(
                      height: 64.h,
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: selectedTypes[entry.key]
                            ? Colors.grey[100]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey[300]!,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/types_icons/Pokémon_${typesList[entry.key]}_Type_Icon.png',
                              height: 24.h,
                              width: 24.h,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              typesList[entry.key],
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: 32.h),
        Text(
          "Weaknesses",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(height: 16.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: typesList
                .asMap()
                .entries
                .map(
                  (entry) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedWeaknesses[entry.key] =
                            !selectedWeaknesses[entry.key];
                      });
                    },
                    child: Container(
                      height: 64.h,
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: selectedWeaknesses[entry.key]
                            ? Colors.grey[100]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey[300]!,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/types_icons/Pokémon_${typesList[entry.key]}_Type_Icon.png',
                              height: 24.h,
                              width: 24.h,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              typesList[entry.key],
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
