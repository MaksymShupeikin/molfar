import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppPalette {
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E2C);

  static const Color primaryYellow = Color(0xFFFFD600);
  static const Color secondaryCyan = Color(0xFF00E5FF);
  static const Color neonRed = Color(0xFFFF3D00);

  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB0B0C3);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppPalette.background,
    );
  }
}

class CyberInputStyle {
  static TextStyle mainStyle({
    required bool isFocused,
    required double fontSize,
    required double letterSpacing,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.manrope(
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      color: isFocused ? Colors.black : AppPalette.secondaryCyan,
      shadows: [
        Shadow(
          color: AppPalette.secondaryCyan.withOpacity(0.6),
          blurRadius: isFocused ? 10 : 6,
        ),
      ],
    );
  }

  static TextStyle hintStyle({
    required bool isFocused,
    required double fontSize,
    required double letterSpacing,
  }) {
    return GoogleFonts.manrope(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      letterSpacing: letterSpacing,
      color: isFocused
          ? Colors.black.withAlpha(155)
          : AppPalette.secondaryCyan.withAlpha(125),
      shadows: [
        Shadow(
          color: AppPalette.secondaryCyan.withOpacity(0.6),
          blurRadius: isFocused ? 10 : 6,
        ),
      ],
    );
  }

  static InputDecoration decoration({
    required String hintText,
    required TextStyle hintStyle,
  }) {
    return InputDecoration(
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      filled: false,
      hintText: hintText,
      hintStyle: hintStyle,
    );
  }
}
