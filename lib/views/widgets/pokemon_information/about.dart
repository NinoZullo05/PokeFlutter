import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Models/pokemon.dart';
import 'package:myapp/Utils/capitalize.dart';
import 'package:myapp/Utils/palette.dart';

class AboutPokemon extends StatelessWidget {
  final Pokemon pokemon;

  const AboutPokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    List<String> firstTwoAbilities = pokemon.abilitiesList.length >= 2
        ? pokemon.abilitiesList.sublist(0, 2)
        : pokemon.abilitiesList;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "No description provided in the Pokémon API", // TODO_ : Search another API that contains this information
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: constraints.maxWidth < 360 ? 12.sp : 14.sp,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      color: Colors.grey[300],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 24.h, horizontal: 12.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${pokemon.weight} kg",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: constraints.maxWidth < 360
                                                ? 14.sp
                                                : 16.sp,
                                          ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      "Weight",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            fontSize: constraints.maxWidth < 360
                                                ? 10.sp
                                                : 12.sp,
                                          ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 76.h,
                                  width: 1.5,
                                  color: gray[300],
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${pokemon.height} m",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: constraints.maxWidth < 360
                                                ? 14.sp
                                                : 16.sp,
                                          ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      "Height",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            fontSize: constraints.maxWidth < 360
                                                ? 10.sp
                                                : 12.sp,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                      padding: EdgeInsets.all(20.r),
                      color: Colors.grey[300],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 24.h, horizontal: 12.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: pokemon.typesList.map((type) {
                                        String typeName =
                                            type.toLowerCase().capitalize();
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.w),
                                          child: Image(
                                            image: AssetImage(
                                              "assets/types_icons/Pokémon_${typeName}_Type_Icon.png",
                                            ),
                                            height: constraints.maxWidth < 360
                                                ? 30.r
                                                : 38.r,
                                            width: constraints.maxWidth < 360
                                                ? 30.r
                                                : 38.r,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(height: 10.h),
                                    Center(
                                      child: Text(
                                        "Category",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              fontSize:
                                                  constraints.maxWidth < 360
                                                      ? 10.sp
                                                      : 12.sp,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 76.h,
                                  width: 1.5,
                                  color: gray[300],
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 4.w,
                                      children:
                                          firstTwoAbilities.map((ability) {
                                        int index =
                                            firstTwoAbilities.indexOf(ability);
                                        return Row(
                                          children: [
                                            Text(
                                              ability.capitalize(),
                                              style: TextStyle(
                                                fontSize:
                                                    constraints.maxWidth < 360
                                                        ? 12.sp
                                                        : 16.sp,
                                              ),
                                            ),
                                            if (index !=
                                                firstTwoAbilities.length - 1)
                                              Text(
                                                ", ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      fontSize:
                                                          constraints.maxWidth <
                                                                  360
                                                              ? 12.sp
                                                              : 16.sp,
                                                    ),
                                              ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      firstTwoAbilities.length > 1
                                          ? "Abilities"
                                          : "Ability",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            fontSize: constraints.maxWidth < 360
                                                ? 10.sp
                                                : 12.sp,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
