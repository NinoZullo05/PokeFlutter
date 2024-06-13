import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Utils/palette.dart';

class FilterPopup extends StatefulWidget {
  final List<String> generations;
  final List<bool> selectedGenerations;
  final Function(int) onGenerationSelected;

  const FilterPopup({
    super.key,
    required this.generations,
    required this.selectedGenerations,
    required this.onGenerationSelected,
  });

  @override
  _FilterPopupState createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
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
  double _currentWeightValue = 20; // Default value for weight
  int _currentHeightValue = 170;
  List<bool> selectedTypes = List<bool>.filled(18, false);
  List<bool> selectedWeaknesses = List<bool>.filled(18, false);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height *
          0.9, // Increase the height to 90%
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  width: 32.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                "Filters",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 32.h),
              Text(
                "Generations",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SizedBox(height: 16.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.generations
                      .asMap()
                      .entries
                      .map(
                        (entry) => GestureDetector(
                          onTap: () {
                            widget.onGenerationSelected(entry.key);
                            setState(() {});
                          },
                          child: Container(
                            height: 64.h,
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: widget.selectedGenerations[entry.key]
                                  ? gray[100]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: gray[300]!,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Generation ${intToRoman(entry.key + 1)}',
                                style: Theme.of(context).textTheme.labelLarge,
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
                              selectedTypes[entry.key] =
                                  !selectedTypes[entry.key];
                            });
                          },
                          child: Container(
                            height: 64.h,
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: selectedTypes[entry.key]
                                  ? gray[100]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: gray[300]!,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/types_icons/Pokémon_${entry.value}_Type_Icon.png',
                                    height: 24.h,
                                    width: 24.h,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    entry.value,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: selectedWeaknesses[entry.key]
                                  ? gray[100]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: gray[300]!,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/types_icons/Pokémon_${entry.value}_Type_Icon.png',
                                    height: 24.h,
                                    width: 24.h,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    entry.value,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
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
              Row(
                children: [
                  Text(
                    "Weight",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const Spacer(),
                  Text(
                      "${_currentWeightValue.toStringAsFixed(1)} kg", // Show weight with one decimal place
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              SizedBox(height: 16.h),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: gray[300],
                  inactiveTrackColor: gray[200],
                  thumbColor: Colors.yellow,
                  overlayColor: Colors.yellow.withOpacity(0.2),
                  valueIndicatorColor: Colors.yellow,
                  valueIndicatorTextStyle: TextStyle(
                    color: gray[500],
                  ),
                ),
                child: Slider(
                  value: _currentWeightValue,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  label: _currentWeightValue.toStringAsFixed(1),
                  onChanged: (double value) {
                    setState(() {
                      _currentWeightValue = value;
                    });
                  },
                ),
              ),
              Row(
                children: [
                  Text(
                    "Height",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const Spacer(),
                  Text(
                    "$_currentHeightValue cm",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: gray[300],
                  inactiveTrackColor: gray[200],
                  thumbColor: Colors.yellow,
                  overlayColor: Colors.yellow.withOpacity(0.2),
                  valueIndicatorColor: Colors.yellow,
                  valueIndicatorTextStyle: TextStyle(
                    color: gray[5000],
                  ),
                ),
                child: Slider(
                  value: _currentHeightValue.toDouble(),
                  min: 100,
                  max: 200,
                  divisions: 10,
                  label: _currentHeightValue.toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentHeightValue = value.toInt();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String intToRoman(int number) {
    if (number < 1 || number > 20) {
      throw Exception('Il numero deve essere compreso tra 1 e 20.');
    }

    final List<String> romanSymbols = [
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
      'VIII',
      'IX',
      'X',
      'XI',
      'XII',
      'XIII',
      'XIV',
      'XV',
      'XVI',
      'XVII',
      'XVIII',
      'XIX',
      'XX'
    ];
    return romanSymbols[number - 1];
  }
}
