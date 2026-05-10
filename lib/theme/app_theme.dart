import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const accent = Color(0xFF2ECC71);
  static const accent2 = Color(0xFF27AE60);
  static const accentDim = Color(0x262ECC71);
  static const darkBg = Color(0xFF121212);
  static const darkSurface = Color(0xFF1E1E1E);
  static const darkSurface2 = Color(0xFF252525);
  static const darkSurface3 = Color(0xFF2A2A2A);
  static const darkText1 = Color(0xFFFFFFFF);
  static const darkText2 = Color(0xFFA0A0A0);
  static const darkText3 = Color(0xFF606060);
  static const darkBorder = Color(0x14FFFFFF);
  static const darkBorder2 = Color(0x1FFFFFFF);
  static const lightBg = Color(0xFFF5F5F7);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurface2 = Color(0xFFF0F0F2);
  static const lightSurface3 = Color(0xFFE8E8EA);
  static const lightText1 = Color(0xFF111111);
  static const lightText2 = Color(0xFF666666);
  static const lightText3 = Color(0xFF999999);
  static const lightBorder = Color(0x0F000000);
  static const lightBorder2 = Color(0x1A000000);
  static const red = Color(0xFFFF6B6B);
  static const orange = Color(0xFFFFA94D);
  static const blue = Color(0xFF74C0FC);
  static const purple = Color(0xFFCC5DE8);
}

class AppTheme {
  static ThemeData dark() => _build(Brightness.dark);
  static ThemeData light() => _build(Brightness.light);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBg : AppColors.lightBg;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final text1 = isDark ? AppColors.darkText1 : AppColors.lightText1;
    final text2 = isDark ? AppColors.darkText2 : AppColors.lightText2;
    final text3 = isDark ? AppColors.darkText3 : AppColors.lightText3;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final border2 = isDark ? AppColors.darkBorder2 : AppColors.lightBorder2;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme(
        brightness: brightness,
        background: bg,
        surface: surface,
        primary: AppColors.accent,
        secondary: AppColors.accent2,
        onBackground: text1,
        onSurface: text1,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        error: AppColors.red,
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.spaceGrotesk(fontSize: 36, fontWeight: FontWeight.w700, color: text1, letterSpacing: -0.5),
        displayMedium: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700, color: text1, letterSpacing: -0.5),
        displaySmall: GoogleFonts.spaceGrotesk(fontSize: 22, fontWeight: FontWeight.w700, color: text1, letterSpacing: -0.3),
        headlineLarge: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w600, color: text1),
        headlineMedium: GoogleFonts.dmSans(fontSize: 17, fontWeight: FontWeight.w600, color: text1),
        headlineSmall: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: text1),
        bodyLarge: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w400, color: text1),
        bodyMedium: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w400, color: text1),
        bodySmall: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w400, color: text2),
        labelLarge: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500, color: text1),
        labelMedium: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w500, color: text2),
        labelSmall: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w500, color: text3),
      ),
      // cardTheme: CardTheme(
      //   color: surface,
      //   elevation: 0,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20),
      //     side: BorderSide(color: border, width: 1),
      //   ),
      // ),
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.spaceGrotesk(fontSize: 22, fontWeight: FontWeight.w700, color: text1),
        iconTheme: IconThemeData(color: text1),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: bg.withOpacity(0.92),
        indicatorColor: AppColors.accentDim,
        elevation: 0,
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.accent);
          }
          return GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w500, color: text3);
        }),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(color: AppColors.accent, size: 22);
          }
          return IconThemeData(color: text3, size: 22);
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: border2)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: border2)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.accent, width: 1.5)),
        hintStyle: GoogleFonts.dmSans(color: text3, fontSize: 15),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600),
          elevation: 0,
        ),
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 1),
    );
  }
}
