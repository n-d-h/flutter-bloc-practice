import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final void Function()? onTap;
  final double shadowHeight;
  final double height;
  final double width;
  final BoxDecoration? decoration;
  final Duration duration;
  final Widget content;

  const CustomButton({
    super.key,
    this.onTap,
    this.shadowHeight = 5,
    this.height = 60,
    this.width = 200,
    this.decoration,
    this.duration = const Duration(milliseconds: 70),
    this.content = const Text(
      'Click Me!',
      style: TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
    ),
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late double position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    position = widget.shadowHeight;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) {
        setState(() {
          position = widget.shadowHeight;
        });
      },
      onTapDown: (_) {
        setState(() {
          position = 0;
        });
      },
      onTapCancel: () {
        setState(() {
          position = widget.shadowHeight;
        });
      },
      onTap: widget.onTap,
      child: SizedBox(
        height: widget.height + widget.shadowHeight,
        width: widget.width,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: widget.height,
                width: widget.width,
                decoration: _getDecorationWithOpacity(widget.decoration, opacity: 0.7),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.easeIn,
              bottom: position,
              duration: widget.duration,
              child: Container(
                height: widget.height,
                width: widget.width,
                alignment: Alignment.center,
                decoration: _getDecorationWithOpacity(widget.decoration),
                child: widget.content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

BoxDecoration _getDecorationWithOpacity(BoxDecoration? decoration, {double opacity = 1}) {
  if (decoration == null) {
    return BoxDecoration(
      color: Colors.blue.withOpacity(opacity),
      borderRadius: BorderRadius.circular(12),
    );
  } else {
    return decoration.copyWith(
      color: (decoration.color ?? Colors.blue).withOpacity(opacity),
    );
  }
}
