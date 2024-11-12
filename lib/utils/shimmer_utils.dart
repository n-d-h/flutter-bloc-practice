import 'package:bloc_learner/utils/color_utils.dart';
import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:flutter/material.dart';

class ShimmerUtils {
  static Color baseColor = const Color(0xFF4A4A4A);
  static Color highlightColor = const Color(0xFF5A5A5A);
  static final shimmerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.centerRight,
    colors: <Color>[baseColor, baseColor, highlightColor, baseColor, baseColor],
    stops: const <double>[0.0, 0.35, 0.5, 0.65, 1.0],
    tileMode: TileMode.clamp,
    // colors: [
    //   Color(0xFF4A4A4A),
    //   Color(0xFF5A5A5A),
    //   Color(0xFF4A4A4A),
    // ],
    // stops: [
    //   0.1,
    //   0.2,
    //   0.4,
    // ],
    // begin: Alignment(-1.0, -0.3),
    // end: Alignment(1.0, 0.3),
  );
}
