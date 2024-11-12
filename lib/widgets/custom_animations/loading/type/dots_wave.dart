import 'package:bloc_learner/utils/color_utils.dart';
import 'package:flutter/material.dart';

class WaveDot extends AnimatedWidget {
  final Color color;

  const WaveDot({
    super.key,
    required Animation<double> animation,
    required this.color,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Container(
      width: 10,
      height: animation.value,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class WaveDots extends StatefulWidget {
  final int numberOfDots;
  final double beginTweenValue;
  final double endTweenValue;
  final Color? color;
  final bool hasBackground;

  const WaveDots({
    this.numberOfDots = 3,
    this.beginTweenValue = 5.0,
    this.endTweenValue = 10.0,
    this.color,
    this.hasBackground = false,
    super.key,
  });

  @override
  State<WaveDots> createState() =>
      _WaveDotsState();
}

class _WaveDotsState
    extends State<WaveDots> with TickerProviderStateMixin {
  late final List<AnimationController> controllers;
  late final List<Animation<double>> animations;
  late final List<Widget> _widgets;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(widget.numberOfDots, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      );
    });

    animations = List.generate(widget.numberOfDots, (index) {
      return Tween(
        begin: widget.beginTweenValue,
        end: widget.endTweenValue,
      ).animate(controllers[index])
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            controllers[index].reverse();
          }
          if (index == widget.numberOfDots - 1 &&
              status == AnimationStatus.dismissed) {
            controllers[0].forward();
          }
          if (animations[index].value > widget.endTweenValue / 2 &&
              index < widget.numberOfDots - 1) {
            controllers[index + 1].forward();
          }
        });
    });

    _widgets = List.generate(widget.numberOfDots, (index) {
      return WaveDot(
        animation: animations[index],
        color: widget.color ?? HexColor.fromHex('#B79292'),
      );
    });

    // Animate the first dot initially
    controllers[0].forward();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: widget.hasBackground ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: widget.hasBackground
              ? const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
              spreadRadius: 0.0,
            ),
          ]
              : null,
        ),
        height: 30.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _widgets,
        ),
      ),
    );
  }
}