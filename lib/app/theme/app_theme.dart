import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.bgLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primary,
        surface: AppColors.surfaceLight,
        error: AppColors.error,
        onPrimary: AppColors.white,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: AppColors.textPrimaryLight,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(color: AppColors.textPrimaryLight, fontSize: 16),
        bodyMedium: TextStyle(color: AppColors.textSecondaryLight, fontSize: 14),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.fieldBgLight,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle: const TextStyle(color: AppColors.textSecondaryLight),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.bgDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        secondary: AppColors.primaryDark,
        surface: AppColors.surfaceDark,
        error: AppColors.error,
        onPrimary: Color(0xFF072126),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: AppColors.textPrimaryDark,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(color: AppColors.textPrimaryDark, fontSize: 16),
        bodyMedium: TextStyle(color: AppColors.textSecondaryDark, fontSize: 14),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.fieldBgDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryDark, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle: const TextStyle(color: AppColors.textSecondaryDark),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: const Color(0xFF072126),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
