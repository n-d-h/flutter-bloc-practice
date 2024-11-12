import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'calculator_event.dart';

part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(const CalculatorState()) {
    on<CalculatorButtonPressed>(_onCalculatorButtonPressed);
  }

  FutureOr<void> _onCalculatorButtonPressed(
      CalculatorButtonPressed event, Emitter<CalculatorState> emit) {
    switch (event.buttonText) {
      case 'AC':
        emit(state.copyWith(
          number: 0,
          newNumber: false,
          res: '0',
          operation: '',
          history: '',
        ));
        break;
      case 'C':
        emit(state.copyWith(
          number: 0,
          newNumber: false,
          operation: '',
          res: '0',
        ));
        break;
      case '<':
        if (state.res.isNotEmpty) {
          emit(
            state.copyWith(
              res: state.res.length > 1
                  ? state.res.substring(0, state.res.length - 1)
                  : '0',
            ),
          );
        }
        break;
      case '+/-':
        emit(
          state.copyWith(
            res: (double.parse(state.res) * -1).toString(),
          ),
        );
        break;
      case '+':
      case '-':
      case 'x':
      case '÷':
        _handleOperator(event, emit);
        break;
      case '=':
        _calculateResult(emit, finalize: true);
        break;
      default:
        _handleNumber(event, emit);
    }
  }

  void _handleOperator(
      CalculatorButtonPressed event, Emitter<CalculatorState> emit) {
    if (state.operation.isNotEmpty && state.res.isNotEmpty) {
      _calculateResult(emit, finalize: true);
      emit(
        state.copyWith(
          number: double.parse(state.res),
          newNumber: true,
          operation: event.buttonText,
        ),
      );
    } else {
      emit(
        state.copyWith(
          number: double.parse(state.res),
          newNumber: true,
          operation: event.buttonText,
          res: state.res,
        ),
      );
    }
  }

  void _handleNumber(
      CalculatorButtonPressed event, Emitter<CalculatorState> emit) {
    if (state.res == '0' || state.res.isEmpty || state.newNumber!) {
      emit(state.copyWith(
        res: event.buttonText,
        newNumber: false,
      ));
    } else {
      emit(state.copyWith(res: state.res + event.buttonText));
    }
  }

  void _calculateResult(Emitter<CalculatorState> emit,
      {bool finalize = false}) {
    double second = double.parse(state.res);
    double result;

    debugPrint("${state.number} ${state.operation} $second");

    switch (state.operation) {
      case '+':
        result = state.number! + second;
        break;
      case '-':
        result = state.number! - second;
        break;
      case 'x':
        result = state.number! * second;
        break;
      case '÷':
        result = state.number! / second;
        break;
      default:
        result = second;
    }

    emit(
      state.copyWith(
        res: _formatNumber(result),
        number: finalize ? null : result,
        operation: finalize ? '' : state.operation,
        history:
            "${_formatNumber(state.number ?? 0)} ${state.operation} ${_formatNumber(second)}",
      ),
    );

    if (!finalize) {
      emit(state.copyWith(operation: state.operation));
    }
  }

  String _formatNumber(double number) {
    if (number == number.toInt()) {
      return number.toInt().toString();
    } else {
      return number.toStringAsFixed(3).replaceFirst(RegExp(r'\.?0*$'), '');
    }
  }
}
