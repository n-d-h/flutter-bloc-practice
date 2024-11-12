import 'package:bloc_learner/common/assets.dart';
import 'package:bloc_learner/routes.dart';
import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:bloc_learner/utils/rive_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rive/rive.dart';

class RiveSignInForm extends StatefulWidget {
  const RiveSignInForm({super.key});

  @override
  State<RiveSignInForm> createState() => _RiveSignInFormState();
}

class _RiveSignInFormState extends State<RiveSignInForm> {
  final formKey = GlobalKey<FormState>();

  bool isShowLoading = false;

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 12,
                  color: DarkMode.getForegroundColor(context).withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              textField(context, true),
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 12,
                  color: DarkMode.getForegroundColor(context).withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              textField(context, false),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                child: ElevatedButton.icon(
                  onPressed: () => signInAnimationHandle(context),
                  icon: const Icon(
                    CupertinoIcons.arrow_right,
                    color: Color(0xFFFE0037),
                  ),
                  label: const Text(
                    'Sign in to DWCK',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF77D8E),
                    minimumSize: const Size(double.infinity, 56),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isShowLoading) ...[
          Positioned.fill(
            child: Column(
              children: [
                const Spacer(),
                SizedBox.square(
                  dimension: 100,
                  child: RiveAnimation.asset(
                    Assets.riveCheck,
                    onInit: (artBoard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(artBoard);
                      check = controller.findSMI("Check") as SMITrigger;
                      error = controller.findSMI("Error") as SMITrigger;
                      reset = controller.findSMI("Reset") as SMITrigger;
                    },
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],

        //confetti
        Positioned.fill(
          child: Column(
            children: [
              const Spacer(),
              SizedBox.square(
                dimension: 100,
                child: Transform.scale(
                  scale: 7,
                  child: RiveAnimation.asset(
                    Assets.riveConfetti,
                    onInit: (artBoard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(artBoard);
                      confetti =
                          controller.findSMI("Trigger explosion") as SMITrigger;
                    },
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ],
    );
  }

  void signInAnimationHandle(BuildContext context) {
    setState(() {
      isShowLoading = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (formKey.currentState!.validate()) {
        // Fire check first
        check.fire();

        // Delay confetti firing after check finishes (2 seconds)
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });
          Future.delayed(const Duration(milliseconds: 60), () {
            confetti.fire();
          });
          Future.delayed(const Duration(seconds: 1), () {
            Routes.goTo(
              context,
              Routes.riveHomeScreen,
              transitionType: PageTransitionType.fade,
            );
          });
        });
      } else {
        error.fire();
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });
        });
      }
    });
  }

  Container textField(BuildContext context, isEmail) {
    return Container(
      margin: const EdgeInsets.fromLTRB(1, 8, 1, 16),
      // padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: ShapeDecoration(
        color: DarkMode.getNeumorphismBackground(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          // side: const BorderSide(
          //   width: 0.5,
          //   color: Colors.transparent,
          // ),
        ),
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTapOutside: (details) {
          FocusScope.of(context).unfocus();
        },
        textInputAction: isEmail ? TextInputAction.next : TextInputAction.done,
        onSaved: (pwd) {},
        obscureText: true,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: DarkMode.getNeumorphismBackground(context),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 0.5,
              color: DarkMode.getListTileTitleColor(context).withOpacity(0.5),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 0.5,
              color: DarkMode.getListTileTitleColor(context).withOpacity(0.5),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 0.5,
              color: DarkMode.getListTileTitleColor(context).withOpacity(0.5),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              width: 0.5,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              width: 0.5,
              color: Colors.red,
            ),
          ),
          errorStyle: const TextStyle(height: 0),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SvgPicture.asset(
                isEmail ? Assets.emailIcon : Assets.passwordIcon),
          ),
        ),
      ),
    );
  }
}
