import 'package:flutter/material.dart';

abstract final class AppColors {
  static const burgundy = Color(0xFF6F1D2C);
  static const burgundyDark = Color(0xFF3D111B);
  static const gold = Color(0xFFB08A3E);
  static const cream = Color(0xFFF8F1E5);
  static const warmSurface = Color(0xFFFFFBF4);
  static const ink = Color(0xFF282321);
  static const darkSurface = Color(0xFF211B1B);
}

abstract final class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

abstract final class AppRadius {
  static const card = 18.0;
  static const control = 12.0;
}

enum ReaderPalette { light, dark, amoled }

ThemeData buildAppTheme(
  Brightness brightness, {
  ReaderPalette palette = ReaderPalette.light,
}) {
  final amoled = palette == ReaderPalette.amoled;
  final dark = brightness == Brightness.dark || palette != ReaderPalette.light;
  final background = amoled
      ? Colors.black
      : dark
      ? const Color(0xFF171313)
      : AppColors.cream;
  final surface = amoled
      ? Colors.black
      : dark
      ? AppColors.darkSurface
      : AppColors.warmSurface;
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.burgundy,
    brightness: dark ? Brightness.dark : Brightness.light,
    primary: dark ? const Color(0xFFD98A9B) : AppColors.burgundy,
    secondary: AppColors.gold,
    surface: surface,
  );
  final base = ThemeData(
    useMaterial3: true,
    brightness: scheme.brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: background,
    fontFamily: 'Inter',
  );
  return base.copyWith(
    textTheme: base.textTheme.copyWith(
      displaySmall: base.textTheme.displaySmall?.copyWith(
        fontFamily: 'SourceSerif4',
        fontWeight: FontWeight.w700,
        color: scheme.onSurface,
      ),
      headlineMedium: base.textTheme.headlineMedium?.copyWith(
        fontFamily: 'SourceSerif4',
        fontWeight: FontWeight.w700,
      ),
      titleLarge: base.textTheme.titleLarge?.copyWith(
        fontFamily: 'SourceSerif4',
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: base.textTheme.bodyLarge?.copyWith(height: 1.55),
    ),
    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.55)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.control),
        borderSide: BorderSide.none,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: surface,
      indicatorColor: scheme.primaryContainer,
    ),
  );
}
