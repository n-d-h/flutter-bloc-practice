import 'dart:math' as math;
import 'dart:ui';

import 'package:bloc_learner/common/assets.dart';
import 'package:flutter/material.dart';

const double minHeight = 130;
const double iconStartSize = 44;
const double iconEndSize = 120;
const double iconStartMarginTop = 36;
const double iconEndMarginTop = 80;
const double iconsVerticalSpacing = 24;
const double iconsHorizontalSpacing = 16;

class ExhibitionBottomSheet extends StatefulWidget {
  const ExhibitionBottomSheet({super.key});

  @override
  State<ExhibitionBottomSheet> createState() => _ExhibitionBottomSheetState();
}

class _ExhibitionBottomSheetState extends State<ExhibitionBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double get maxHeight => MediaQuery.of(context).size.height;

  double get headerTopMargin =>
      lerp(20, 20 + MediaQuery.of(context).padding.top);

  double get headerFontSize => lerp(14, 24);

  double get itemBorderRadius => lerp(8, 24);

  double get iconLeftBorderRadius => itemBorderRadius;

  double get iconRightBorderRadius => lerp(8, 0);

  double get iconSize => lerp(iconStartSize, iconEndSize);

  double iconTopMargin(int index) =>
      lerp(iconStartMarginTop,
          iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize)) +
      headerTopMargin;

  double iconLeftMargin(int index) =>
      lerp(index * (iconsHorizontalSpacing + iconStartSize), 0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value)!;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          height: lerp(minHeight, maxHeight),
          left: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            // onTap: _toggle,
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                color: const Color(0xFF162A49),
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                        _controller.status == AnimationStatus.completed
                            ? 0
                            : 24)),
              ),
              child: Stack(
                children: <Widget>[
                  Visibility(
                    visible: _controller.status != AnimationStatus.completed,
                    child: topIndicator(),
                  ),
                  SheetHeader(
                    fontSize: headerFontSize,
                    topMargin: headerTopMargin,
                  ),
                  for (Event event in events) _buildFullItem(event),
                  for (Event event in events) _buildIcon(event),
                  MenuButton(onTap: _toggle),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget topIndicator() {
    return Positioned(
      top: 8,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 45,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(Event event) {
    int index = events.indexOf(event);
    return Positioned(
      height: iconSize,
      width: iconSize,
      top: iconTopMargin(index),
      left: iconLeftMargin(index),
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(iconLeftBorderRadius),
          right: Radius.circular(iconRightBorderRadius),
        ),
        child: Image.asset(
          event.assetName,
          fit: BoxFit.cover,
          alignment: Alignment(lerp(1, 0), 0),
        ),
      ),
    );
  }

  Widget _buildFullItem(Event event) {
    int index = events.indexOf(event);
    return ExpandedEventItem(
      topMargin: iconTopMargin(index),
      leftMargin: iconLeftMargin(index),
      height: iconSize,
      isVisible: _controller.status == AnimationStatus.completed,
      borderRadius: itemBorderRadius,
      title: event.title,
      date: event.date,
    );
  }

  void _toggle() {
    final bool isOpen = _controller.status == AnimationStatus.completed;
    _controller.fling(velocity: isOpen ? -2 : 2);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta! / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0) {
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    } else if (flingVelocity > 0.0) {
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    } else {
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
    }
  }
}

class ExpandedEventItem extends StatelessWidget {
  final double topMargin;
  final double leftMargin;
  final double height;
  final bool isVisible;
  final double borderRadius;
  final String title;
  final String date;

  const ExpandedEventItem(
      {super.key,
      required this.topMargin,
      required this.height,
      required this.isVisible,
      required this.borderRadius,
      required this.title,
      required this.date,
      required this.leftMargin});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      left: leftMargin,
      right: 0,
      height: height,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white,
          ),
          padding: EdgeInsets.only(left: height).add(const EdgeInsets.all(8)),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (isVisible) {
      return Column(
        children: <Widget>[
          Text(title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Text(
                '1 ticket',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                date,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: <Widget>[
              Icon(Icons.place, color: Colors.grey.shade400, size: 16),
              Text(
                'Science Park 10 25A',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
              )
            ],
          )
        ],
      );
    }
    return const SizedBox();
  }
}

final List<Event> events = [
  Event(Assets.paralax3, 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event(Assets.paralax1, 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event(Assets.paralax2, 'Dawan District Guangdong Hong Kong', '4.28-31'),
];

class Event {
  final String assetName;
  final String title;
  final String date;

  Event(this.assetName, this.title, this.date);
}

class SheetHeader extends StatelessWidget {
  final double fontSize;
  final double topMargin;

  const SheetHeader(
      {super.key, required this.fontSize, required this.topMargin});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      child: Text(
        'Booked Exhibition',
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final VoidCallback onTap;

  const MenuButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 24,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(6),
          child: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}
