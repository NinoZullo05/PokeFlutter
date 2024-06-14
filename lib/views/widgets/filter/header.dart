import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Utils/palette.dart';

class FilterPopupHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: 32.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: gray[400],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
