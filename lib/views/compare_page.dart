import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Utils/palette.dart';
import 'package:myapp/views/widgets/bottom_nav_bar.dart';
import 'package:myapp/views/widgets/top_text.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({super.key});

  @override
  State<ComparePage> createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
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
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.275,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: gray[100],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: InkWell(
                      // onTap: () => ,
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
              Container(
                alignment: Alignment.center,
                width: 80.r,
                height: 80.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.casino_outlined,
                  size: 50.r,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15.h,
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
                  // onTap: () => ,
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
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
    );
  }
}
