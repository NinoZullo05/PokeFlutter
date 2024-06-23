import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompareButton extends StatefulWidget {
  final bool isReadyToCompare;

  const CompareButton({super.key, required this.isReadyToCompare});

  @override
  State<CompareButton> createState() => _CompareButtonState();
}

class _CompareButtonState extends State<CompareButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {

      },
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.isReadyToCompare ? Colors.yellow : Colors.yellow[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: Text(
        'Compare',
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          color: widget.isReadyToCompare ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
