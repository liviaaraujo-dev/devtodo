import 'package:devtodo/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.white, opacity: 0.8),
    textTheme: GoogleFonts.interTextTheme().copyWith(
      headline1: GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white)),
      headline2: GoogleFonts.lexendDeca(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headline3: GoogleFonts.inter(
          fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
      bodyText2: GoogleFonts.inter(
          color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
      bodyText1: GoogleFonts.inter(color: Color(0xFFFAFAFC), fontSize: 13),
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    focusColor: AppColors.laranja,
    colorScheme: const ColorScheme.light(),
    iconTheme: const IconThemeData(color: Colors.black, opacity: 0.8),
    textTheme: GoogleFonts.interTextTheme().copyWith(
        headline1: GoogleFonts.inter(
            textStyle: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Color(0xfff585666))),
        headline2: GoogleFonts.lexendDeca(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        headline3: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF585666)),
        bodyText1: GoogleFonts.inter(color: Color(0xFFFAFAFC), fontSize: 13),
        bodyText2: GoogleFonts.inter(
            color: Color(0xFF585666),
            fontSize: 17,
            fontWeight: FontWeight.w600),
        button: GoogleFonts.inter(
            textStyle: TextStyle(
                color: AppColors.text,
                fontSize: 16,
                fontWeight: FontWeight.w500))),
  );
}
