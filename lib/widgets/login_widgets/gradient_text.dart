import 'package:flutter/material.dart';

class GradientText extends StatefulWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  State<GradientText> createState() => _GradientTextState();
}

class _GradientTextState extends State<GradientText> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => widget.gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(widget.text, style: widget.style),
    );
  }
}

class AnimatedGradientText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final List<Color> colors;
  final Duration duration;

  const AnimatedGradientText({
    super.key,
    required this.text,
    required this.colors,
    this.style,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Gradient> _gradientAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _gradientAnimation = _controller.drive(
      GradientTween(
        begin: LinearGradient(
          colors: widget.colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        end: LinearGradient(
          colors: widget.colors.reversed.toList(),
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _gradientAnimation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => _gradientAnimation.value.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(widget.text, style: widget.style),
        );
      },
    );
  }
}

class GradientTween extends Tween<Gradient> {
  GradientTween({super.begin, super.end});

  @override
  Gradient lerp(double t) {
    final beginGradient = begin as LinearGradient;
    final endGradient = end as LinearGradient;

    // Interpolate between the colors of the gradients
    final interpolatedColors = <Color>[
      Color.lerp(beginGradient.colors[0], endGradient.colors[0], t)!,
      Color.lerp(beginGradient.colors[1], endGradient.colors[1], t)!,
    ];

    return LinearGradient(
      begin: beginGradient.begin,
      end: beginGradient.end,
      colors: interpolatedColors,
    );
  }
}


// class _AnimatedGradientTextState extends State<AnimatedGradientText>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize the controller for a continuous loop
//     _controller = AnimationController(
//       duration: widget.duration,
//       vsync: this,
//     )..repeat(); // Repeats the animation infinitely
//
//     // Tween between 0 and 1, making sure the gradient moves smoothly
//     _animation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.linear, // Linear curve for a smooth animation
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return ShaderMask(
//           // blendMode: BlendMode.srcIn,
//           shaderCallback: (bounds) {
//             // The moving gradient
//             return LinearGradient(
//               begin: Alignment.bottomLeft,
//               end: Alignment.topRight,
//               colors: widget.colors,
//               stops: [
//                 _animation.value - 0.3, // Shift the gradient start
//                 _animation.value, // Shift the gradient end
//               ],
//               tileMode: TileMode
//                   .repeated, // Ensures the gradient does not "mirror" but resets
//             ).createShader(
//               Rect.fromLTWH(0, 0, bounds.width, bounds.height),
//             );
//           },
//           child: Text(widget.text, style: widget.style),
//         );
//       },
//     );
//   }
// }


