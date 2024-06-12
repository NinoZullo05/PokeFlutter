import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utils/palette.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  List<String> generations = [];
  List<bool> selectedGenerations = [];

  @override
  void initState() {
    super.initState();
    _getPokemonGenerations();
  }

  Future<void> _getPokemonGenerations() async {
    final url = Uri.parse('https://pokeapi.co/api/v2/generation');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        setState(() {
          generations = results.map((gen) => gen['name'] as String).toList();
          selectedGenerations = List<bool>.filled(generations.length, false);
        });
      } else {
        print('Failed to load generations');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

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
        onTap: generations.isEmpty ? null : () => _openFilterPopup(context),
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

  void _openFilterPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      builder: (BuildContext bc) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    width: 32.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  "Filters",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 32.h),
                Text(
                  "Generations",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(
                  height: 16.h,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: generations
                        .asMap()
                        .entries
                        .map(
                          (entry) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedGenerations[entry.key] =
                                    !selectedGenerations[entry.key];
                              });
                            },
                            child: Container(
                              height: 64.h,
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: selectedGenerations[entry.key]
                                    ? gray[100]
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: gray[300]!,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Generation ${intToRoman(entry.key + 1)}',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Text("Types", style: Theme.of(context).textTheme.labelLarge,),
              ],
            ),
          ),
        );
      },
    );
  }

  String intToRoman(int number) {
    if (number < 1 || number > 20) {
      throw Exception('Il numero deve essere compreso tra 1 e 20.');
    }

    final List<String> romanSymbols = [
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
      'VIII',
      'IX',
      'X',
      'XI',
      'XII',
      'XIII',
      'XIV',
      'XV',
      'XVI',
      'XVII',
      'XVIII',
      'XIX',
      'XX'
    ];
    return romanSymbols[number - 1];
  }
}
