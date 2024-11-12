import 'package:bloc_learner/bloc/switch/switch_bloc.dart';
import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:bloc_learner/widgets/3d_button.dart';
import 'package:bloc_learner/widgets/neumorphism_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Switch Screen')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dark Mode',
                  style: TextStyle(
                    color: context.watch<SwitchBloc>().state.isSwitched
                        ? Colors.grey
                        : Colors.black87,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                BlocBuilder<SwitchBloc, SwitchState>(
                  buildWhen: (previous, current) =>
                      previous.isSwitched != current.isSwitched,
                  builder: (context, state) {
                    return Switch(
                      value: state.isSwitched,
                      onChanged: (value) {
                        context.read<SwitchBloc>().add(
                              EnableOrDisableNotification(),
                            );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Container(
                  height: 200,
                  color: Colors.red.withOpacity(state.slider),
                );
              },
            ),
            const SizedBox(height: 50),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Slider(
                    min: 0.2,
                    value: state.slider,
                    onChanged: (value) {
                      context
                          .read<SwitchBloc>()
                          .add(SliderEvent(slider: value));
                    });
              },
            ),
            const SizedBox(height: 30),
            const CustomButton(),
            const SizedBox(height: 30),
            NeumorphismButton(
              isRespondButton: true,
              isDeepPressed: false,
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
      ),
    );
  }
}
