import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterPopupGenerations extends StatelessWidget {
  final List<String> generations;
  final List<bool> selectedGenerations;
  final Function(int) onGenerationSelected;

  const FilterPopupGenerations({
Key? key,
required this.generations,
required this.selectedGenerations,
required this.onGenerationSelected,
}) : super(key: key);

@override
Widget build(BuildContext context) {
return Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
"Generations",
style: Theme.of(context).textTheme.labelLarge,
),
SizedBox(height: 16.h),
SingleChildScrollView(
scrollDirection: Axis.horizontal,
child: Row(
children: generations
.asMap()
.entries
.map(
(entry) => GestureDetector(
onTap: () {
onGenerationSelected(entry.key);
},
child: Container(
height: 64.h,
margin: EdgeInsets.symmetric(horizontal: 4.w),
padding: EdgeInsets.symmetric(horizontal: 16.w),
decoration: BoxDecoration(
color: selectedGenerations[entry.key]
? Colors.grey[100]
: Colors.white,
borderRadius: BorderRadius.circular(12),
border: Border.all(
color: Colors.grey[300]!,
),
),
child: Center(
child: Text(
"Generation ${entry.key + 1}",
style: Theme.of(context).textTheme.labelLarge,
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