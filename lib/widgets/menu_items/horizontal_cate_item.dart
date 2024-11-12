import 'package:flutter/material.dart';

class HorizontalCategoryItem extends StatelessWidget {
  final String category;
  final bool isSelected;

  const HorizontalCategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.white,
        boxShadow: isSelected
            ? [BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 10)]
            : [],
      ),
      child: Center(
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}