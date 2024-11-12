import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:flutter/material.dart';

class AppBarDeleteButton extends StatelessWidget {
  final int length;
  final void Function()? onPressed;
  const AppBarDeleteButton({super.key, required this.length, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Badge(
        backgroundColor: Colors.orange,
        alignment: Alignment.topRight,
        largeSize: 20,
        padding: const EdgeInsets.symmetric(horizontal: 7),
        label: Text(
          length.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        child: IconButton(
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(12),
            shape: const CircleBorder(),
            backgroundColor:
                DarkMode.getBackgroundColor(context).withOpacity(0.8),
          ),
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
