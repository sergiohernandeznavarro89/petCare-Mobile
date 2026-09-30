import 'package:flutter/material.dart';

class AppTheme {
  // Modo Claro: Color Terracota / Teja cálido que combina armoniosamente con el Beige
  static const Color primaryTerracotta = Color(0xFFB35434); // Teja cálido / Arcilla elegante
  static const Color secondaryCoral = Color(0xFFE29578);
  static const Color backgroundBeige = Color(0xFFF5EFE6); // Beige suave
  static const Color cardColorLight = Color(0xFFFFFFFF);

  // Modo Oscuro: El color Teal original que había antes
  static const Color primaryTealOriginal = Color(0xFF006D77);
  static const Color accentTealDark = Color(0xFF83C5BE);
  static const Color backgroundDark = Color(0xFF121920);
  static const Color surfaceDark = Color(0xFF1E2732);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryTerracotta,
        primary: primaryTerracotta,
        secondary: secondaryCoral,
        surface: backgroundBeige,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: backgroundBeige,
      cardTheme: CardThemeData(
        color: cardColorLight,
        surfaceTintColor: const Color(0xFFFAF6F0),
        elevation: 1.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primaryTerracotta),
        titleTextStyle: TextStyle(
          color: primaryTerracotta,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFFEDE4D7),
        indicatorColor: const Color(0xFFE5D5C4),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryTerracotta);
          }
          return IconThemeData(color: Colors.grey.shade600);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: primaryTerracotta,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            );
          }
          return TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          );
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryTerracotta, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        labelStyle: TextStyle(color: Colors.grey.shade600),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryTerracotta,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryTerracotta,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryTerracotta,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryTealOriginal,
        primary: accentTealDark,
        secondary: secondaryCoral,
        surface: backgroundDark,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: backgroundDark,
      cardTheme: CardThemeData(
        color: surfaceDark,
        surfaceTintColor: Colors.transparent,
        elevation: 1.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF18222B),
        indicatorColor: const Color(0xFF263744),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: accentTealDark);
          }
          return IconThemeData(color: Colors.grey.shade400);
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: accentTealDark, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: secondaryCoral, width: 2),
        ),
        labelStyle: const TextStyle(color: Colors.white54),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: accentTealDark,
        foregroundColor: Colors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentTealDark,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: secondaryCoral,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
