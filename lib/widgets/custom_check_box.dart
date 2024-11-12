import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool? value;
  final void Function(bool?)? onChanged;
  const CustomCheckBox({super.key, this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      side: const BorderSide(
        color: Colors.grey,
        width: 1.4,
      ),
      checkColor: Colors.black,
      fillColor: MaterialStateColor.resolveWith((states) {
        const Set<MaterialState> interactiveStates =
        <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.selected,
        };
        if (states.any(interactiveStates.contains)) {
          return Colors.greenAccent;
        }
        return Colors.transparent;
      }),
      value: value,
      onChanged: onChanged,
    );
  }
}
