import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterPopupOrderBy extends StatefulWidget {
  final String initialValue;
  final Function(String) onChanged;

  const FilterPopupOrderBy({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  _FilterPopupOrderByState createState() => _FilterPopupOrderByState();
}

class _FilterPopupOrderByState extends State<FilterPopupOrderBy> {
  late String _orderBy;

  @override
  void initState() {
    super.initState();
    _orderBy = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Order By",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const Spacer(),
        SizedBox(
          width: 150.w,
          child: DropdownButton<String>(
            value: _orderBy,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: Theme.of(context).textTheme.labelLarge,
            underline: Container(
              height: 2,
              color: Colors.yellow,
            ),
            onChanged: (String? newValue) {
              setState(() {
                _orderBy = newValue!;
                widget.onChanged(newValue);
              });
            },
            items: <String>['A-Z', 'Z-A']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
