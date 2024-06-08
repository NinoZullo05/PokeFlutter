import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/palette.dart';

class SearchBarF extends StatelessWidget {
  const SearchBarF({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          searchBar(context),
          filterButton(),
        ],
      ),
    );
  }

  Container filterButton() => Container(
        height: 48.r,
        width: 48.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: gray[200],
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.filter_alt_outlined,
          size: 24.r,
        ),
      );

  Container searchBar(BuildContext context) => Container(
        height: 48 ,
        width: 256.w,
        decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: gray[200]!),
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12 ,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.search,
              size: 24.r,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              "Search a pokémon",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: gray[300], fontSize: 12.sp),
            ),
            
          ],
        ),
      );
}
