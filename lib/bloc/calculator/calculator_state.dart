part of 'calculator_bloc.dart';

class CalculatorState extends Equatable {
  final double? number;
  final bool? newNumber;
  final String history;
  final String res;
  final String operation;

  const CalculatorState({
    this.number,
    this.newNumber = false,
    this.res = '0',
    this.operation = '',
    this.history = '',
  });

  CalculatorState copyWith({
    double? number,
    bool? newNumber,
    String? res,
    String? operation,
    String? history,
  }) {
    return CalculatorState(
      number: number ?? this.number,
      newNumber: newNumber ?? this.newNumber,
      res: res ?? this.res,
      operation: operation ?? this.operation,
      history: history ?? this.history,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [number, newNumber, history, res, operation];
}
