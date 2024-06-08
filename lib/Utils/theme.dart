import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'palette.dart';

final pokeFlutterTheme = ThemeData(
    primarySwatch: gray,
    textTheme: TextTheme(
      displaySmall: GoogleFonts.roboto(
        fontSize: 36.sp,
        fontWeight: FontWeight.w400,
        color: gray[500],
      ),
      titleSmall: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: gray[500],
        letterSpacing: 0.1.sp,
      ),
      headlineLarge: GoogleFonts.roboto(
        color: gray,
        fontSize: 32.sp,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: GoogleFonts.roboto(
        color: gray,
        fontSize: 28.sp,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: GoogleFonts.roboto(
        color: gray,
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: GoogleFonts.roboto(
        color: gray,
        fontSize: 22.sp,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: GoogleFonts.roboto(
        color: gray,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15.sp,
      ),
      labelLarge: GoogleFonts.roboto(
        color: gray,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1.sp,
      ),
      labelMedium: GoogleFonts.roboto(
        color: gray,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5.sp,
      ),
      labelSmall: GoogleFonts.roboto(
        color: gray,
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5.sp,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: gray,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15.sp,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: gray,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25.sp,
      ),
      bodySmall: GoogleFonts.roboto(
        color: gray,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4.sp,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: gray[500],
      unselectedItemColor: gray[300],
    ));