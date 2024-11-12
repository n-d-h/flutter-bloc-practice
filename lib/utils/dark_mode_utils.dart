import 'package:bloc_learner/bloc/switch/switch_bloc.dart';
import 'package:bloc_learner/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkMode {
  static bool isDarkMode(BuildContext context) {
    final isSwitched = context.watch<SwitchBloc>().state.isSwitched;
    return isSwitched;
  }

  static Color getBackgroundColor(BuildContext context) {
    return isDarkMode(context)
        ? const ColorScheme.dark().surface
        : const ColorScheme.light().surface;
  }

  static Color getButtonColor(BuildContext context) {
    return isDarkMode(context)
        ? const ColorScheme.light().surface
        : const ColorScheme.dark().surface;
  }

  static Color getForegroundColor(BuildContext context) {
    return isDarkMode(context) ? Colors.white : Colors.black;
  }

  static Color getListTileTitleColor(BuildContext context) {
    return isDarkMode(context)
        ? Colors.white.withOpacity(0.5)
        : Colors.black.withOpacity(0.5);
  }

  static getBrightness(BuildContext context) {
    return isDarkMode(context) ? Brightness.dark : Brightness.light;
  }

  static getNeumorphismBackground(BuildContext context) {
    return isDarkMode(context)
        ? ColorPalette.darkBackGround
        : ColorPalette.lightBackGround;
  }

  static getNeumorphismDarkShadow(BuildContext context) {
    return isDarkMode(context)
        ? ColorPalette.neuDarkModeDarkShadow
        : ColorPalette.neuDarkModeLightShadow;
  }

  static getNeumorphismLightShadow(BuildContext context) {
    return isDarkMode(context)
        ? ColorPalette.neuLightModeDarkShadow
        : ColorPalette.neuLightModeLightShadow;
  }

  static getNeumorphismOffset(BuildContext context,
      {bool isDeepPressed = false}) {
    if (!isDeepPressed) return NeuOffset.normal;
    return isDarkMode(context)
        ? NeuOffset.darkModeDeepPressed
        : NeuOffset.lightModeDeepPressed;
  }

  static getNeumorphismBlur(BuildContext context,
      {bool isDeepPressed = false}) {
    if (isDeepPressed) {
      return isDarkMode(context)
          ? NeuBlur.darkModeDeepPressed
          : NeuBlur.lightModeDeepPressed;
    } else {
      return isDarkMode(context) ? NeuBlur.darkMode : NeuBlur.lightMode;
    }
  }

  static getThemeMode(BuildContext context) {
    return isDarkMode(context) ? ThemeMode.dark : ThemeMode.light;
  }
}

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorPalette.lightBackGround,
    colorScheme: const ColorScheme.light().copyWith(
      surface: ColorPalette.lightBackGround,
    ),
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      elevation: 3,
      backgroundColor: ColorPalette.lightBackGround,
      surfaceTintColor: ColorPalette.lightBackGround,
      shadowColor: Colors.black,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all<Color>(Colors.black),
      trackOutlineWidth: WidgetStateProperty.all<double>(0),
      trackOutlineColor: WidgetStateProperty.all<Color>(Colors.transparent),
      thumbIcon: WidgetStateProperty.all<Icon>(
        const Icon(
          Icons.wb_sunny_rounded,
          color: Colors.white,
        ),
      ),
    ),
    fontFamily: GoogleFonts.lexend().fontFamily,
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorPalette.darkBackGround,
    colorScheme: const ColorScheme.dark().copyWith(
      surface: ColorPalette.darkBackGround,
    ),
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.lexend().fontFamily,
    appBarTheme: AppBarTheme(
      elevation: 3,
      backgroundColor: ColorPalette.darkBackGround,
      surfaceTintColor: ColorPalette.darkBackGround,
      shadowColor: ColorPalette.neuDarkModeLightShadow,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all<Color>(Colors.white),
      trackOutlineWidth: WidgetStateProperty.all<double>(0),
      trackOutlineColor: WidgetStateProperty.all<Color>(Colors.transparent),
      thumbIcon: WidgetStateProperty.all<Icon>(
        const Icon(
          Icons.nights_stay_rounded,
          color: Colors.black,
        ),
      ),
    ),
    useMaterial3: true,
  );
}
