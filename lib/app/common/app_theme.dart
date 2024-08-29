import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static themeData() => ThemeData(
        colorScheme: ColorScheme.dark(
          primary: AppColors.primaryColor,
          secondary: AppColors.primaryColor,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          brightness: Brightness.light,
        ),
        fontFamily: 'Raleway',
        // scaffoldBackgroundColor: AppColors,
        useMaterial3: true,
        textTheme: GoogleFonts.ralewayTextTheme(
          const TextTheme(
            headlineLarge: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
            ),
            headlineMedium: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
            headlineSmall: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            labelLarge: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            titleLarge: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
            titleMedium: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
            titleSmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            bodyMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            bodySmall: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        datePickerTheme: const DatePickerThemeData(
          headerHeadlineStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          confirmButtonStyle: ButtonStyle(
              textStyle: WidgetStatePropertyAll<TextStyle>(TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ))),
          cancelButtonStyle: ButtonStyle(
              textStyle: WidgetStatePropertyAll<TextStyle>(TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ))),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.primaryColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      );

  static TextStyle hyperLinkStyle() {
    return TextStyle(
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    );
  }
}
