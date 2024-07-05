import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Utils/palette.dart';

class FilterPopupWeightAndHeight extends StatefulWidget {
  const FilterPopupWeightAndHeight({super.key});

  @override
  _FilterPopupWeightAndHeightState createState() =>
      _FilterPopupWeightAndHeightState();
}

class _FilterPopupWeightAndHeightState
    extends State<FilterPopupWeightAndHeight> {
  double _currentWeightValue = 20;
  int _currentHeightValue = 170;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Weight",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Spacer(),
            Text(
              "${_currentWeightValue.toStringAsFixed(1)} kg",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        SizedBox(height: 16.h),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.grey[300],
            inactiveTrackColor: Colors.grey[200],
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
        SizedBox(height: 16.h),
        Row(
          children: [
            Text(
              "Height",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Spacer(),
            Text(
              "$_currentHeightValue cm",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        SizedBox(height: 16.h),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.grey[300],
            inactiveTrackColor: Colors.grey[200],
            thumbColor: Colors.yellow,
            overlayColor: Colors.yellow.withOpacity(0.2),
            valueIndicatorColor: Colors.yellow,
            valueIndicatorTextStyle: TextStyle(
              color: gray[500],
            ),
          ),
          child: Slider(
            value: _currentHeightValue.toDouble(),
            min: 40,
            max: 220,
            divisions: 18,
            label: _currentHeightValue.toString(),
            onChanged: (double value) {
              setState(() {
                _currentHeightValue = value.toInt();
              });
            },
          ),
        ),
      ],
    );
  }
}
