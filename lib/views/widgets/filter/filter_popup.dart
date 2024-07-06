import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/views/widgets/filter/generations_filter.dart';
import 'package:myapp/views/widgets/filter/header.dart';
import 'package:myapp/views/widgets/filter/order_by_filter.dart';
import 'package:myapp/views/widgets/filter/types_filter.dart';
import 'package:myapp/views/widgets/filter/weight_height_filter.dart';

class FilterContent extends StatelessWidget {
  final List<String> generations;
  final List<bool> selectedGenerations;
  final Function(int) onGenerationSelected;
  final Function(String) onOrderByChanged;

  const FilterContent({
    super.key,
    required this.generations,
    required this.selectedGenerations,
    required this.onGenerationSelected,
    required this.onOrderByChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16.h),
          const FilterPopupHeader(),
          FilterPopupGenerations(
            generations: generations,
            selectedGenerations: selectedGenerations,
            onGenerationSelected: onGenerationSelected,
          ),
          SizedBox(height: 32.h),
          const FilterPopupTypesAndWeaknesses(),
          SizedBox(height: 32.h),
          const FilterPopupWeightAndHeight(),
          SizedBox(height: 32.h),
          FilterPopupOrderBy(
            initialValue: 'A-Z',
            onChanged: onOrderByChanged,
          ),
        ],
      ),
    );
  }
}
