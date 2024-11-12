import 'package:bloc_learner/widgets/custom_animations/loading/type/dots_wave.dart';
import 'package:bloc_learner/widgets/custom_animations/loading/type/jumping_dots.dart';
import 'package:flutter/material.dart';

enum TypeLoading { dots_1, dots_2, circular }

class LoadingBox extends StatelessWidget {
  final TypeLoading type;
  final Color? color;
  final bool hasBackground;

  const LoadingBox({
    super.key,
    this.type = TypeLoading.dots_1,
    this.color,
    this.hasBackground = false,
  });

  factory LoadingBox.jumpingDots({Color? color, bool hasBackground = false}) {
    return LoadingBox(
      type: TypeLoading.dots_1,
      color: color,
      hasBackground: hasBackground,
    );
  }

  factory LoadingBox.waveDots({Color? color, bool hasBackground = false}) {
    return LoadingBox(
      type: TypeLoading.dots_2,
      color: color,
      hasBackground: hasBackground,
    );
  }

  factory LoadingBox.circular({bool hasBackground = false}) {
    return LoadingBox(
      type: TypeLoading.circular,
      hasBackground: hasBackground,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case TypeLoading.dots_1:
        return JumpingDots(
          color: color,
          hasBackground: hasBackground,
        );
      case TypeLoading.dots_2:
        return WaveDots(
          color: color,
          hasBackground: hasBackground,
        );
      case TypeLoading.circular:
      default:
        return defaultLoading();
    }
  }

  Center defaultLoading() {
    return Center(
      child: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: hasBackground ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: hasBackground
              ? const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3.0,
                    spreadRadius: 0.0,
                  ),
                ]
              : null,
        ),
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: color,
        ),
      ),
    );
  }
}
