import 'package:bloc_learner/routes.dart';
import 'package:bloc_learner/utils/color_utils.dart';
import 'package:bloc_learner/widgets/login_widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonLogin extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const ButtonLogin({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 40, 16, 0),
      width: size.width,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            HexColor.fromHex('#56CCF2'),
            HexColor.fromHex('#2F80ED'),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: HexColor.fromHex('#56CCF2').withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(40),
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(12),
              ),
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
          shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
        ),
        onPressed: () async {
          if (!formKey.currentState!.validate()) {
            return;
          }

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLogged', true);

          Routes.goToAndKill(
            context,
            Routes.home,
            transitionType: PageTransitionType.fade,
          );
        },
        child: GradientText(
          'Sign in to DWCK',
          gradient: LinearGradient(
            colors: [
              HexColor.fromHex('#fceabb'),
              HexColor.fromHex('#f8b500'),
            ],
          ),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
