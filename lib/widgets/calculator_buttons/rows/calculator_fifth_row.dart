import 'package:bloc_learner/widgets/calculator_buttons/calculator_button.dart';
import 'package:bloc_learner/widgets/neumorphism_button.dart';
import 'package:flutter/material.dart';

class CalculatorFifthRow extends StatelessWidget {
  const CalculatorFifthRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // CalculatorButton(
        //   text: '+/-',
        //   fillColor: 0xFF8ac4d0,
        //   textColor: 0xFF000000,
        // ),
        // CalculatorButton(
        //   text: '0',
        //   fillColor: 0xFF8ac4d0,
        //   textColor: 0xFF000000,
        // ),
        // CalculatorButton(
        //   text: '.',
        //   fillColor: 0xFF8ac4d0,
        //   textColor: 0xFF000000,
        // ),
        // CalculatorButton(
        //   text: '=',
        //   fillColor: 0xFFf0a500,
        //   textColor: 0xFF000000,
        // ),
        NeumorphismButton(
          title: const Text('+/-', style: TextStyle(fontSize: 24)),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        NeumorphismButton(
          title: const Text('0', style: TextStyle(fontSize: 24)),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        NeumorphismButton(
          title: const Icon(Icons.circle, size: 7),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        NeumorphismButton(
          title: const Text('=', style: TextStyle(fontSize: 24)),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}
