import 'package:bloc_learner/widgets/calculator_buttons/calculator_button.dart';
import 'package:bloc_learner/widgets/neumorphism_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatorSecondRow extends StatelessWidget {
  const CalculatorSecondRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // CalculatorButton(
        //   text: '1',
        //   fillColor: 0xFF8ac4d0,
        //   textColor: 0xFF000000,
        // ),
        // CalculatorButton(
        //   text: '2',
        //   fillColor: 0xFF8ac4d0,
        //   textColor: 0xFF000000,
        // ),
        // CalculatorButton(
        //   text: '3',
        //   fillColor: 0xFF8ac4d0,
        //   textColor: 0xFF000000,
        // ),
        // CalculatorButton(
        //   text: 'x',
        //   fillColor: 0xFFf0a500,
        //   textColor: 0xFF000000,
        // ),
        NeumorphismButton(
          title: const Text('1', style: TextStyle(fontSize: 24)),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        NeumorphismButton(
          title: const Text('2', style: TextStyle(fontSize: 24)),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        NeumorphismButton(
          title: const Text('3', style: TextStyle(fontSize: 24)),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        NeumorphismButton(
          title: const Icon(CupertinoIcons.multiply, size: 24),
          isRespondButton: false,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}
