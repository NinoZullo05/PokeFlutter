import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utils/palette.dart';

class SearchBarF extends StatefulWidget {
  const SearchBarF({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  _SearchBarFState createState() => _SearchBarFState();
}

class _SearchBarFState extends State<SearchBarF> {
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

  InkWell filterButton() => InkWell(
        onTap: () => _openFilterPopup(context),
        child: Container(
          height: 48.sp,
          width: 48.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: gray[200],
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.filter_alt_outlined,
            size: 24.r,
          ),
        ),
      );

  Container searchBar(BuildContext context) => Container(
        height: 48.sp,
        width: 256.sp,
        decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: gray[200]!),
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
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
            Expanded(
              child: TextField(
                controller: widget.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search a Pokémon",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: gray[300], fontSize: 12.sp),
                ),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black, fontSize: 12.sp),
                onChanged: (text) {
                  widget.searchController.value =
                      widget.searchController.value.copyWith(
                    text: text,
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: text.length),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
}

void _openFilterPopup(context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (BuildContext bc) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Filters",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 16.h),
              TextButton(
                onPressed: () {},
                child: const Text("Test 1"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Test 2"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Test 3"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
