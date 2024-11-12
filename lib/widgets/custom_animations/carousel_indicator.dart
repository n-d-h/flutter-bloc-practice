import 'package:bloc_learner/bloc/switch/switch_bloc.dart';
import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselDot extends AnimatedWidget {
  final Color color;

  const CarouselDot({
    super.key,
    required Animation<double> animation,
    required this.color,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: animation.value,
      // Animate the width
      height: 10.0,
      // Fixed height
      decoration: BoxDecoration(
        color: animation.value < endTweenWidth ? color.withOpacity(0.2) : color,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

const double beginTweenWidth = 10.0;
const double endTweenWidth = 30.0;

class CarouselIndicator extends StatefulWidget {
  final int numberOfDots;
  final Color? color;
  final int selectedIndex;

  const CarouselIndicator({
    super.key,
    this.numberOfDots = 3,
    this.color,
    required this.selectedIndex,
  });

  @override
  State<CarouselIndicator> createState() => _CarouselIndicatorState();
}

class _CarouselIndicatorState extends State<CarouselIndicator>
    with TickerProviderStateMixin {
  late final List<AnimationController> controllers;
  late final List<Animation<double>> animations;
  late final List<Widget> _widgets;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(widget.numberOfDots, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 50),
        vsync: this,
      );
    });

    animations = controllers
        .map((controller) => Tween<double>(
              begin: beginTweenWidth,
              end: endTweenWidth,
            ).animate(
              CurvedAnimation(
                parent: controller,
                curve: Curves.elasticInOut,
              ),
            ))
        .toList();

    _widgets = List.generate(widget.numberOfDots, (index) {
      final switchBloc = BlocProvider.of<SwitchBloc>(context, listen: false);
      final isDarkMode = switchBloc.state.isSwitched;
      return CarouselDot(
        animation: animations[index],
        color: isDarkMode
            ? widget.color ?? Colors.grey
            : widget.color ?? Colors.black45,
      );
    });

    for (int i = 0; i < widget.numberOfDots; i++) {
      if (i == widget.selectedIndex) {
        Future.delayed(const Duration(milliseconds: 40), () {
          controllers[i].forward();
        });
      } else {
        controllers[i].reverse();
      }
    }
  }

  @override
  void didUpdateWidget(CarouselIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    for (int i = 0; i < widget.numberOfDots; i++) {
      if (i == widget.selectedIndex) {
        controllers[i].forward();
      } else {
        controllers[i].reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _widgets,
    );
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
