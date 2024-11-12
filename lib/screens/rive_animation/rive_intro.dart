import 'dart:ui';

import 'package:bloc_learner/common/assets.dart';
import 'package:bloc_learner/widgets/rive_animation/rive_buton.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

class RiveIntro extends StatefulWidget {
  const RiveIntro({super.key});

  @override
  State<RiveIntro> createState() => _RiveIntroState();
}

class _RiveIntroState extends State<RiveIntro> {
  late rive.RiveAnimationController _btnController;
  bool isDialogShown = false;

  @override
  void initState() {
    _btnController = rive.OneShotAnimation('active', autoplay: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            // height: 100,
            width: size.width * 1.7,
            bottom: 200,
            left: 100,
            child: Image.asset(Assets.splineBackground),
          ),
          _blurBackground(20, 10),
          const rive.RiveAnimation.asset(Assets.riveShape),
          _blurBackground(30, 30),
          AnimatedPositioned(
            top: isDialogShown ? -50 : 0,
            duration: const Duration(milliseconds: 240),
            height: size.height,
            width: size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: SizedBox(
                        width: 260,
                        child: Column(
                          children: [
                            const Spacer(),
                            const Text(
                              'Learn design & code',
                              style: TextStyle(
                                fontSize: 60,
                                fontFamily: "Poppins",
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Rive is a real-time interactive design tool that allows you to design, animate, and integrate your assets into your Flutter project.',
                            ),
                            const Spacer(flex: 2),
                            RiveButton(
                              btnController: _btnController,
                              onDialogShown: (val) {
                                setState(() {
                                  isDialogShown = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'Purchase includes access to the course and all future updates.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _blurBackground(double sigmaX, double sigmaY) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: const SizedBox.shrink(),
      ),
    );
  }
}
