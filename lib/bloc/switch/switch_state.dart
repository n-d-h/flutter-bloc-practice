part of 'switch_bloc.dart';

class SwitchState extends Equatable {
  final bool isSwitched;
  final double slider;

  const SwitchState({this.isSwitched = false, this.slider = 1.0});

  SwitchState copyWith({bool? isSwitched, double? slider}) {
    return SwitchState(
      isSwitched: isSwitched ?? this.isSwitched,
      slider: slider ?? this.slider,
    );
  }

  @override
  List<Object> get props => [isSwitched, slider];
}
