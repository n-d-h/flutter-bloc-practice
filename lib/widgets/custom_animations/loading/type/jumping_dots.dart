// import 'package:bloc_learner/utils/color_utils.dart';
// import 'package:flutter/material.dart';
//
// class JumpingDot extends AnimatedWidget {
//   final Color color;
//
//   const JumpingDot({
//     super.key,
//     required Animation<Offset> animation,
//     required this.color,
//   }) : super(listenable: animation);
//
//   @override
//   Widget build(BuildContext context) {
//     final Animation<Offset> animation = listenable as Animation<Offset>;
//     return SlideTransition(
//       position: animation,
//       child: Container(
//         width: 10,
//         height: 10,
//         margin: const EdgeInsets.symmetric(horizontal: 1),
//         decoration: BoxDecoration(
//           color: color,
//           shape: BoxShape.circle,
//         ),
//       ),
//     );
//   }
// }
//
// class JumpingDots extends StatefulWidget {
//   final int numberOfDots;
//   final Color? color;
//   final bool hasBackground;
//
//   const JumpingDots({
//     this.numberOfDots = 3,
//     this.color,
//     this.hasBackground = false,
//     super.key,
//   });
//
//   @override
//   State<JumpingDots> createState() => _JumpingDotsState();
// }
//
// const beginTweenValue = Offset.zero;
// const endTweenValue = Offset(0, -0.7);
//
// class _JumpingDotsState extends State<JumpingDots>
//     with TickerProviderStateMixin {
//   late final List<AnimationController> controllers;
//   late final List<Animation<Offset>> animations;
//   late final List<Widget> _widgets;
//
//   @override
//   void initState() {
//     super.initState();
//     controllers = List.generate(widget.numberOfDots, (index) {
//       return AnimationController(
//         duration: const Duration(milliseconds: 1000),
//         vsync: this,
//       );
//     });
//
//     animations = List.generate(widget.numberOfDots, (index) {
//       final curve = CurvedAnimation(
//         parent: controllers[index],
//         curve: Curves.linear,
//       );
//       return Tween<Offset>(
//         begin: beginTweenValue,
//         end: endTweenValue,
//       ).animate(curve)
//         ..addStatusListener((status) {
//           if (status == AnimationStatus.completed) {
//             controllers[index].reverse();
//           }
//           if (index == widget.numberOfDots - 1 &&
//               status == AnimationStatus.dismissed) {
//             controllers[0].forward();
//           }
//           if (animations[index].value.dy < end / 2 &&
//               index < widget.numberOfDots - 1) {
//             controllers[index + 1].forward();
//           }
//         });
//     });
//
//     _widgets = List.generate(widget.numberOfDots, (index) {
//       return JumpingDot(
//         animation: animations[index],
//         color: widget.color ?? HexColor.fromHex('#B79292'),
//       );
//     });
//
//     // Animate the first dot initially
//     controllers[0].forward();
//   }
//
//   @override
//   void dispose() {
//     for (var controller in controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(7, 10, 7, 6),
//         decoration: BoxDecoration(
//           color: widget.hasBackground ? Colors.white : Colors.transparent,
//           borderRadius: BorderRadius.circular(8.0),
//           boxShadow: widget.hasBackground
//               ? const [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 3.0,
//                     spreadRadius: 0.0,
//                   ),
//                 ]
//               : null,
//         ),
//         height: 30.0,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: _widgets,
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:bloc_learner/utils/color_utils.dart';
import 'package:flutter/material.dart';

class JumpingDot extends AnimatedWidget {
  final Color color;

  const JumpingDot({
    super.key,
    required Animation<Offset> animation,
    required this.color,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<Offset> animation = listenable as Animation<Offset>;
    return SlideTransition(
      position: animation,
      child: Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class JumpingDots extends StatefulWidget {
  final int numberOfDots;
  final Color? color;
  final bool hasBackground;

  const JumpingDots({
    this.numberOfDots = 3,
    this.color,
    this.hasBackground = false,
    super.key,
  });

  @override
  State<JumpingDots> createState() => _JumpingDotsState();
}

const beginTweenValue = Offset.zero;
const endTweenValue = Offset(0, -0.7);

class _JumpingDotsState extends State<JumpingDots>
    with TickerProviderStateMixin {
  late final List<AnimationController> controllers;
  late final List<Animation<Offset>> animations;
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
      final curve = CurvedAnimation(
        parent: controllers[index],
        curve: Curves.easeInOut,
      );
      return Tween<Offset>(
        begin: beginTweenValue,
        end: endTweenValue,
      ).animate(curve);
    });

    _widgets = List.generate(widget.numberOfDots, (index) {
      return JumpingDot(
        animation: animations[index],
        color: widget.color ?? HexColor.fromHex('#B79292'),
      );
    });

    _runAnimation();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _runAnimation() {
    for (var index = 0; index < widget.numberOfDots; index++) {
      // Adding a delay for each dot based on its index
      Future.delayed(Duration(milliseconds: index * 100), () {
        controllers[index].forward().then((_) {
          controllers[index].reverse().then((_) {
            if (index == widget.numberOfDots - 1) {
              // Loop back to the first dot after the last one completes
              _runAnimation();
            }
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(7, 10, 7, 6),
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _widgets,
        ),
      ),
    );
  }
}

