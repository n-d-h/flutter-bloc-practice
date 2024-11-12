import 'package:bloc_learner/bloc/calculator/calculator_bloc.dart';
import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:bloc_learner/widgets/calculator_buttons/rows/calculator_fifth_row.dart';
import 'package:bloc_learner/widgets/calculator_buttons/rows/calculator_first_row.dart';
import 'package:bloc_learner/widgets/calculator_buttons/rows/calculator_fourth_row.dart';
import 'package:bloc_learner/widgets/calculator_buttons/rows/calculator_second_row.dart';
import 'package:bloc_learner/widgets/calculator_buttons/rows/calculator_third_row.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    var neuOffset = DarkMode.getNeumorphismOffset(context, isDeepPressed: true);
    var neuBlur = DarkMode.getNeumorphismBlur(context, isDeepPressed: true);

    return Scaffold(
      // backgroundColor: const Color(0xFF28527a),
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: DarkMode.getNeumorphismBackground(context),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: DarkMode.getNeumorphismDarkShadow(context),
                            offset: neuOffset['down']!,
                            blurRadius: neuBlur['down'],
                            spreadRadius: 1,
                            inset: true,
                          ),
                          BoxShadow(
                            color: DarkMode.getNeumorphismLightShadow(context),
                            offset: -neuOffset['down']!,
                            blurRadius: neuBlur['down'],
                            spreadRadius: 1,
                            inset: true,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 12),
                            alignment: const Alignment(1.0, 1.0),
                            child: BlocBuilder<CalculatorBloc, CalculatorState>(
                              builder: (context, state) {
                                return Text(
                                  state.history,
                                  style: GoogleFonts.lexend(
                                    fontSize: 33,
                                    color: DarkMode.getForegroundColor(context),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            alignment: Alignment.centerRight,
                            child: BlocBuilder<CalculatorBloc, CalculatorState>(
                              builder: (context, state) {
                                return Text(
                                  state.res,
                                  style: GoogleFonts.lexend(
                                    fontSize: 80,
                                    color: DarkMode.getForegroundColor(context),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const CalculatorFirstRow(),
              const SizedBox(height: 15),
              const CalculatorSecondRow(),
              const SizedBox(height: 15),
              const CalculatorThirdRow(),
              const SizedBox(height: 15),
              const CalculatorFourthRow(),
              const SizedBox(height: 15),
              const CalculatorFifthRow(),
            ],
          ),
        ),
      ),
    );
  }
}
