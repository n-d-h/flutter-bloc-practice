import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CustomPageTransition {
  static Route transition(Widget widget, RouteSettings? settings) {
    PageTransitionType? type;
    final arguments = settings?.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      type = arguments['transitionType'];
    }
    return PageTransition(
      child: widget,
      curve: Curves.easeInOut,
      type: type ?? PageTransitionType.rightToLeft,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 200),
    );
  }
}
