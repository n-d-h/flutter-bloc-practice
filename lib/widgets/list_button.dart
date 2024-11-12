import 'package:bloc_learner/utils/color_utils.dart';
import 'package:bloc_learner/widgets/custom_animations/delayed_display.dart';
import 'package:bloc_learner/widgets/custom_animations/loading/loading_box.dart';
import 'package:bloc_learner/widgets/login_widgets/gradient_text.dart';
import 'package:flutter/material.dart';

class ListButton extends StatefulWidget {
  final String title;
  final String? route;
  final bool isTextAnimated;
  final bool isContainerAnimated;
  final List<Color>? backgroundColors;
  final List<Color>? textColors;
  final FontWeight? fontWeight;
  final VoidCallback? onPressed;
  final bool isDropdownButton;
  final Duration delay;

  const ListButton({
    super.key,
    required this.title,
    this.route,
    this.isTextAnimated = false,
    this.isContainerAnimated = false,
    this.backgroundColors,
    this.textColors,
    this.fontWeight,
    this.onPressed,
    this.isDropdownButton = false,
    this.delay = Duration.zero,
  });

  static List<Color> defaultBackgroundColor = [
    HexColor.fromHex('#56CCF2'),
    HexColor.fromHex('#2F80ED'),
  ];
  static const defaultTextColor = [
    Colors.deepOrange,
    Colors.orangeAccent,
  ];

  @override
  State<ListButton> createState() => _ListButtonState();
}

class _ListButtonState extends State<ListButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: widget.delay,
      child: Container(
        decoration: ShapeDecoration(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          gradient: widget.isContainerAnimated ||
                  (widget.backgroundColors ?? []).isNotEmpty &&
                      widget.backgroundColors!.length > 1
              ? LinearGradient(
                  colors: widget.backgroundColors ??
                      ListButton.defaultBackgroundColor,
                )
              : null,
          color: (widget.backgroundColors ?? []).isNotEmpty &&
                      widget.backgroundColors!.length == 1
              ? widget.backgroundColors?.first
              : null,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            backgroundColor: widget.isContainerAnimated ||
                    (widget.backgroundColors ?? []).isNotEmpty
                ? Colors.transparent
                : null,
            shadowColor: widget.isContainerAnimated ||
                    (widget.backgroundColors ?? []).isNotEmpty
                ? Colors.transparent
                : null,
          ),
          onPressed: widget.onPressed ??
              () {
                if ((widget.route ?? '').trim().isEmpty) return;
                setState(() {
                  isLoading = true;
                });
                Future.delayed(const Duration(milliseconds: 1000), () {
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.pushNamed(context, widget.route!);
                });
              },
          child: isLoading
              ? LoadingBox.waveDots(color: widget.textColors?.first)
              : Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: widget.isTextAnimated ||
                              (widget.textColors ?? []).length > 1
                          ? AnimatedGradientText(
                              text: widget.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              colors: widget.textColors ??
                                  ListButton.defaultTextColor,
                              duration: const Duration(milliseconds: 700),
                            )
                          : Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 18,
                                color: widget.textColors?[0],
                                fontWeight: widget.fontWeight,
                              ),
                            ),
                    ),
                    if (widget.isDropdownButton) ...[
                      Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: widget.textColors?.first,
                          size: 26,
                        ),
                      ),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
