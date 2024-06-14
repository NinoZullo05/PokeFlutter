import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/views/widgets/filter/generations_filter.dart';
import 'package:myapp/views/widgets/filter/header.dart';
import 'package:myapp/views/widgets/filter/order_by_filter.dart';
import 'package:myapp/views/widgets/filter/types_filter.dart';
import 'package:myapp/views/widgets/filter/weight_height_filter.dart';

class FilterPopup extends StatefulWidget {
  final List<String> generations;
  final List<bool> selectedGenerations;
  final Function(int) onGenerationSelected;
  final Function(String) onOrderByChanged;

  const FilterPopup({
    Key? key,
    required this.generations,
    required this.selectedGenerations,
    required this.onGenerationSelected,
    required this.onOrderByChanged,
  }) : super(key: key);

  @override
  _FilterPopupState createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  double _currentWeightValue = 20;
  int _currentHeightValue = 170;
  List<bool> selectedTypes = List<bool>.filled(18, false);
  List<bool> selectedWeaknesses = List<bool>.filled(18, false);
  String _orderBy = 'A-Z';

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.1, // Almeno il 10% dell'altezza può essere visibile
      maxChildSize: 0.85, // Massimo apertura fino al 85% dell'altezza
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: EdgeInsets.all(16.h),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                FilterPopupHeader(),
                FilterPopupGenerations(
                  generations: widget.generations,
                  selectedGenerations: widget.selectedGenerations,
                  onGenerationSelected: widget.onGenerationSelected,
                ),
                SizedBox(height: 32.h),
                const FilterPopupTypesAndWeaknesses(),
                SizedBox(height: 32.h),
                const FilterPopupWeightAndHeight(),
                SizedBox(height: 32.h),
                FilterPopupOrderBy(
                  initialValue: _orderBy,
                  onChanged: (newValue) {
                    setState(() {
                      _orderBy = newValue;
                      widget.onOrderByChanged(newValue);
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
