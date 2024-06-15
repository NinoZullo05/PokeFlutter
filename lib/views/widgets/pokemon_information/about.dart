import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/Models/pokemon.dart';
import 'package:myapp/Utils/capitalize.dart';

class AboutPokemon extends StatelessWidget {
  final Pokemon pokemon;

  const AboutPokemon({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(48.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "POKEMON DESCRIPTION (NULL!)",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 20.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  color: Colors.grey[300],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${pokemon.weight} kg",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "Weight",
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                            VerticalDivider(
                              color: Colors.black,
                              thickness: 1.5,
                              width: 20.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${pokemon.height} m",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "Height",
                                  style: Theme.of(context).textTheme.labelSmall,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 10.w),
                                    Row(
                                      children: pokemon.typesList.map((type) {
                                        String typeName =
                                            type.toLowerCase().capitalize();
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          child: Image(
                                            image: AssetImage(
                                              "assets/types_icons/Pokémon_${typeName}_Type_Icon.png",
                                            ),
                                            height: 32.r,
                                            width: 32.r,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Text(
                                    "Category",
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                )
                              ],
                            ),

                            ///     VerticalDivider(
                            //     color: Colors.black,
                            //   thickness: 1.5,
                            //),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // TODO : ADD ABILITIES
                                  "Abilities",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  //"${pokemon.abilitiesList}",
                                  "",
                                  style: TextStyle(fontSize: 16.sp),
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
          ),
        ),
      ),
    );
  }
}
