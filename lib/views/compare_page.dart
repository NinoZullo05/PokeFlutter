import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Utils/palette.dart';
import 'package:myapp/views/widgets/bottom_nav_bar.dart';
import 'package:myapp/views/widgets/compare_button.dart';
import 'package:myapp/views/widgets/top_text.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({super.key});

  @override
  State<ComparePage> createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  bool isReadyToCompare = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 76.h),
                child: StyledText(
                  text: "Comparator",
                  style: textTheme.displaySmall!,
                  textHeight: 44,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  "Select two Pokémon and compare them to see who is the strongest!",
                  style: textTheme.bodyLarge,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.275,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: gray[100],
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isReadyToCompare = true;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Colors.grey[300]!,
                              ),
                              color: Colors.white,
                            ),
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.075,
                            child: Text(
                              "ADD POKEMON",
                              style: textTheme.labelLarge,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.075,
                      ),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.275,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: gray[100],
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isReadyToCompare = true;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Colors.grey[300]!,
                              ),
                              color: Colors.white,
                            ),
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.075,
                            child: Text(
                              "ADD POKEMON",
                              style: textTheme.labelLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.275 -
                        40.r, // Adjusted to overlap equally
                    child: Container(
                      alignment: Alignment.center,
                      width: 80.r,
                      height: 80.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Icon(
                        Icons.casino_outlined,
                        size: 40.r,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: CompareButton(isReadyToCompare: isReadyToCompare),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
    );
  }
}
