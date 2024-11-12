part of 'calculator_bloc.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

class CalculatorButtonPressed extends CalculatorEvent {
  final String buttonText;

  const CalculatorButtonPressed({required this.buttonText});

  @override
  List<Object> get props => [buttonText];
}
