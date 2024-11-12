import 'package:bloc_learner/utils/color_utils.dart';
import 'package:bloc_learner/widgets/login_widgets/glass_morphism.dart';
import 'package:bloc_learner/widgets/login_widgets/gradient_text.dart';
import 'package:flutter/material.dart';

class CardGlass extends StatelessWidget {
  const CardGlass({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GlassMorphism(
      start: 0.5,
      end: 0.2,
      color: HexColor.fromHex('#B79292'),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: SizedBox(
        height: size.height / 2.2,
        width: size.width,
        child: Center(
          child: AnimatedGradientText(
            text: 'DWCK',
            duration: const Duration(seconds: 3),
            colors: [
              Colors.white,
              // HexColor.fromHex('#B79292'),
              HexColor.fromHex('#8A6E6E'),
            ],
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
