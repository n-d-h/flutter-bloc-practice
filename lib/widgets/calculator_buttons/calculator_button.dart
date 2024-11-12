import 'package:bloc_learner/bloc/calculator/calculator_bloc.dart';
import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final int fillColor;
  final int textColor;
  final double textSize;

  const CalculatorButton({
    super.key,
    required this.text,
    this.fillColor = 0xFF8ac4d0,
    this.textColor = 0xFF000000,
    this.textSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: DarkMode.getForegroundColor(context).withOpacity(0.3),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => context
            .read<CalculatorBloc>()
            .add(CalculatorButtonPressed(buttonText: text)),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              context.watch<CalculatorBloc>().state.operation == text
                  ? Color(fillColor).withOpacity(0.2)
                  : Color(fillColor),
          foregroundColor:
              context.watch<CalculatorBloc>().state.operation == text
                  ? Colors.white
                  : Color(textColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(0),
        ),
        child: Text(
          text,
          style: GoogleFonts.rubik(
            fontSize: textSize,
            fontWeight:
                context.watch<CalculatorBloc>().state.operation == text
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
