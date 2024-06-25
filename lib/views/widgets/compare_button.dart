import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompareButton extends StatefulWidget {
  final bool isReadyToCompare;
  final VoidCallback onPressed;

  const CompareButton({
    Key? key,
    required this.isReadyToCompare,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CompareButton> createState() => _CompareButtonState();
}

class _CompareButtonState extends State<CompareButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isReadyToCompare ? widget.onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            widget.isReadyToCompare ? Colors.yellow : Colors.yellow[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: Text(
        'COMPARE!',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: widget.isReadyToCompare ? Colors.black : Colors.grey,
            ),
      ),
    );
  }
}
