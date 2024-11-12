import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  final String category;

  const CategoryHeader({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Text(
        category,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: DarkMode.getForegroundColor(context),
        ),
      ),
    );
  }
}