import 'dart:async';

import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class NeumorphismButton extends StatefulWidget {
  final double height;
  final double width;
  final bool isRespondButton;
  final bool isDeepPressed;
  final BoxShape shape;
  final BorderRadiusGeometry? borderRadius;
  final Widget title;

  const NeumorphismButton({
    super.key,
    this.height = 70,
    this.width = 70,
    this.isRespondButton = true,
    this.isDeepPressed = false,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
    this.title = const Icon(Icons.home, size: 40, color: Colors.green),
  });

  @override
  State<NeumorphismButton> createState() => _NeumorphismButtonState();
}

class _NeumorphismButtonState extends State<NeumorphismButton> {
  bool isDown = false; // button is up
  BorderRadiusGeometry? borderRadius;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.shape == BoxShape.circle) {
      borderRadius = null;
    } else {
      borderRadius = widget.borderRadius;
    }
  }

  void _toggleIsDown() {
    setState(() {
      isDown = !isDown;
    });
  }

  @override
  Widget build(BuildContext context) {
    var neuOffset = DarkMode.getNeumorphismOffset(context,
        isDeepPressed: widget.isDeepPressed);
    var neuBlur = DarkMode.getNeumorphismBlur(context,
        isDeepPressed: widget.isDeepPressed);
    Offset distance = isDown ? neuOffset['down']! : neuOffset['up']!;
    double blur = isDown ? neuBlur['down'] : neuBlur['up'];
    return GestureDetector(
      onTap: () {
        _toggleIsDown();
        if (widget.isRespondButton) {
          Timer(const Duration(milliseconds: 70), () {
            _toggleIsDown();
          });
        }
      },
      onLongPressUp: !widget.isRespondButton ? null : _toggleIsDown,
      onLongPressDown: (_) =>
          !widget.isRespondButton ? null : _toggleIsDown(),
      onLongPressCancel: !widget.isRespondButton ? null : _toggleIsDown,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 70),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: DarkMode.getNeumorphismBackground(context),
          shape: widget.shape,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: DarkMode.getNeumorphismDarkShadow(context),
              offset: distance,
              blurRadius: blur,
              spreadRadius: 1,
              inset: isDown,
            ),
            BoxShadow(
              color: DarkMode.getNeumorphismLightShadow(context),
              offset: -distance,
              blurRadius: blur,
              spreadRadius: 1,
              inset: isDown,
            )
          ],
        ),
        child: Center(child: widget.title)
      ),
    );
  }
}
