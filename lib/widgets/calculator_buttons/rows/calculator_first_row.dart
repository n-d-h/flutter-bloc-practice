import 'package:bloc_learner/widgets/calculator_buttons/calculator_button.dart';
import 'package:bloc_learner/widgets/neumorphism_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatorFirstRow extends StatelessWidget {
  const CalculatorFirstRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // CalculatorButton(
        //   text: 'AC',
        //   fillColor: 0xFF8ac4d0,
        //   textColor: 0xFF000000,
        // ),
        // CalculatorButton(
        //   text: 'C',
        //   fillColor: 0xFF8ac4d0,
        //   textColor: 0xFF000000,
        // ),
        // CalculatorButton(
        //   text: '<',
        //   fillColor: 0xFFf0a500,
        //   textColor: 0xFF000000,
        // ),
        // CalculatorButton(
        //   text: '÷',
        //   fillColor: 0xFFf0a500,
        //   textColor: 0xFF000000,
        // ),
        NeumorphismButton(
          title: const Text('AC', style: TextStyle(fontSize: 24)),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        NeumorphismButton(
          title: const Text('C', style: TextStyle(fontSize: 24)),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        NeumorphismButton(
          // title: const Text('<', style: TextStyle(fontSize: 23)),
          title: const Icon(Icons.backspace_outlined, size: 24),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        NeumorphismButton(
          // title: const Text('÷', style: TextStyle(fontSize: 23)),
          title: const Icon(CupertinoIcons.divide, size: 24),
          isRespondButton: false,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}
