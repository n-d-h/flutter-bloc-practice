import 'package:bloc_learner/widgets/calculator_buttons/calculator_button.dart';
import 'package:bloc_learner/widgets/neumorphism_button.dart';
import 'package:flutter/material.dart';

class CalculatorFourthRow extends StatelessWidget {
  const CalculatorFourthRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // CalculatorButton(
        //   text: '7',
        //   fillColor: 0xFF8ac4d0,
        //   textColor: 0xFF000000,
        // ),
        // CalculatorButton(
        //   text: '8',
        //   fillColor: 0xFF8ac4d0,
        //   textColor: 0xFF000000,
        // ),
        // CalculatorButton(
        //   text: '9',
        //   fillColor: 0xFF8ac4d0,
        //   textColor: 0xFF000000,
        // ),
        // CalculatorButton(
        //   text: '+',
        //   fillColor: 0xFFf0a500,
        //   textColor: 0xFF000000,
        // ),
        NeumorphismButton(
          title: const Text('7', style: TextStyle(fontSize: 24)),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        NeumorphismButton(
          title: const Text('8', style: TextStyle(fontSize: 24)),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        NeumorphismButton(
          title: const Text('9', style: TextStyle(fontSize: 24)),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        NeumorphismButton(
          title: const Icon(Icons.add, size: 24),
          isRespondButton: false,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}
