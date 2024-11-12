import 'package:flutter/material.dart';

class ColorPalette {
  static const darkBackGround = Color.fromRGBO(36, 39, 44, 1);
  static Color lightBackGround = Colors.grey[300]!;
  static Color lightBackGround2 = HexColor.fromHex('#555555');
  static const neuDarkModeDarkShadow = Color.fromRGBO(0, 0, 0, 0.7);
  static Color neuDarkModeLightShadow = Colors.grey[500]!;
  static const neuLightModeDarkShadow = Color.fromRGBO(255, 255, 255, 0.15);
  static Color neuLightModeLightShadow = Colors.white;
  static const Color lineColor = Color.fromRGBO(0, 0, 0, 0.30);
  static const Color black50Color = Color.fromRGBO(0, 0, 0, 0.50);
  static const Color orangeColor = Color.fromRGBO(245, 130, 32, 1);
  static const Color yellowColor = Color.fromRGBO(254, 188, 24, 1);
  static const Color hoverColor = Color.fromRGBO(254, 188, 24, 0.2);
}

class Gradients {
  static const Gradient defaultGradientBackground = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [ColorPalette.yellowColor, ColorPalette.orangeColor]);
}

// class ColorUtils {
//   static ColorUtils? _instance;
//
//   factory ColorUtils() => _instance ??= ColorUtils._();
//
//   ColorUtils._();
//
//   static Color getColorFromHex(String hex) {
//     hex = hex.substring(1);
//     return Color(int.parse("0xff$hex"));
//   }
//
// }

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class NeuOffset {
  static const normal = {
    'up': Offset(3, 3),
    'down': Offset(1, 1),
  };
  static const darkModeDeepPressed = {
    'up': Offset(3, 3),
    'down': Offset(4, 4),
  };
  static const lightModeDeepPressed = {
    'up': Offset(3, 3),
    'down': Offset(2, 2),
  };
}

class NeuBlur {
  static const darkMode = {
    'up': 6.0,
    'down': 0.2,
  };
  static const darkModeDeepPressed = {
    'up': 6.0,
    'down': 2.0,
  };
  static const lightMode = {
    'up': 4.0,
    'down': 1.0,
  };
  static const lightModeDeepPressed = {
    'up': 4.0,
    'down': 5.0,
  };
}
