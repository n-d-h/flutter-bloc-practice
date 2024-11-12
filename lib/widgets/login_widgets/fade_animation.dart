import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({super.key, required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    final opacity = MovieTweenProperty<double>();
    final y = MovieTweenProperty<double>();
    final rotate = MovieTweenProperty<double>();

    final tween = MovieTween()
      ..scene(
              begin: const Duration(seconds: 0),
              end: const Duration(seconds: 1))
          .tween(opacity, Tween(begin: 0.0, end: 1.0))
          .tween(y, Tween(begin: -120.0, end: -50.0),
              curve: Curves.easeInOutSine)
          .tween(rotate, Tween(begin: 0.0, end: -0.4),
              curve: Curves.easeInOutSine)
      ..scene(
              begin: const Duration(seconds: 1),
              end: const Duration(milliseconds: 1500))
          .tween(y, Tween(begin: -50.0, end: 0.0), curve: Curves.easeInOutSine)
          .tween(rotate, Tween(begin: -0.4, end: 0.0), curve: Curves.easeInOutSine);

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (700 * delay).round()),
      tween: tween,
      duration: tween.duration,
      builder: (context, value, child) {
        return Opacity(
          opacity: opacity.from(value),
          child: Transform.translate(
            offset: Offset(0, y.from(value)),
            child: Transform.rotate(
              angle: rotate.from(value),
              alignment: Alignment.center,
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }

// @override
// Widget build(BuildContext context) {
//   final opacity = MovieTweenProperty<double>();
//   final y = MovieTweenProperty<double>();
//   final tween = MovieTween()
//     ..scene(
//             begin: const Duration(seconds: 0),
//             end: const Duration(seconds: 1))
//         .tween(opacity, Tween(begin: 0.0, end: 1.0))
//         .tween(y, Tween(begin: -100.0, end: 0.0), curve: Curves.easeInOutSine);
//
//   return PlayAnimationBuilder<Movie>(
//     tween: tween,
//     // delay: Duration(milliseconds: (700 * delay).round()),
//     duration: tween.duration,
//     builder: (context, value, child) {
//       return Opacity(
//         opacity: opacity.from(value),
//         child: Transform.translate(
//           offset: Offset(0, y.from(value)),
//           child: child,
//         ),
//       );
//     },
//     child: child,
//   );
// }
}
