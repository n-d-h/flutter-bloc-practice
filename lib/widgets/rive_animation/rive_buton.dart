import 'package:bloc_learner/common/assets.dart';
import 'package:bloc_learner/widgets/rive_animation/rive_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';

class RiveButton extends StatelessWidget {
  final RiveAnimationController btnController;
  final void Function(bool) onDialogShown;

  const RiveButton(
      {super.key, required this.btnController, required this.onDialogShown});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        btnController.isActive = true;
        Future.delayed(const Duration(milliseconds: 800), () {
          onDialogShown(true);
          Custom.customSignInDialog(context, (value) {
            onDialogShown(false);
          });
        });
      },
      child: SizedBox(
        height: 64,
        width: 260,
        child: Stack(
          children: [
            RiveAnimation.asset(
              Assets.riveButton,
              controllers: [btnController],
            ),
            const Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.arrow_right,
                    size: 22,
                    color: CupertinoColors.black,
                  ),
                  SizedBox(
                    height: 8,
                    width: 8,
                  ),
                  Text(
                    'Get Started',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
