import 'package:bloc_learner/widgets/calculator_buttons/calculator_button.dart';
import 'package:bloc_learner/widgets/neumorphism_button.dart';
import 'package:flutter/material.dart';

class CalculatorThirdRow extends StatelessWidget {
  const CalculatorThirdRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // CalculatorButton(
        //   text: '4',
        //   fillColor: 0xFF8ac4d0,
        //   textColor: 0xFF000000,
        // ),
        // CalculatorButton(
        //   text: '5',
        //   fillColor: 0xFF8ac4d0,
        //   textColor: 0xFF000000,
        // ),
        // CalculatorButton(
        //   text: '6',
        //   fillColor: 0xFF8ac4d0,
        //   textColor: 0xFF000000,
        // ),
        // CalculatorButton(
        //   text: '-',
        //   fillColor: 0xFFf0a500,
        //   textColor: 0xFF000000,
        // ),
        NeumorphismButton(
          title: const Text('4', style: TextStyle(fontSize: 24)),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        NeumorphismButton(
          title: const Text('5', style: TextStyle(fontSize: 24)),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        NeumorphismButton(
          title: const Text('6', style: TextStyle(fontSize: 24)),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        NeumorphismButton(
          title: const Icon(Icons.remove, size: 24),
          isRespondButton: false,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}
