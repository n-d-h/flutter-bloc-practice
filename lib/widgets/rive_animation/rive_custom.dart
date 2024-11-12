import 'package:bloc_learner/common/assets.dart';
import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:bloc_learner/widgets/rive_animation/rive_sign_in_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Custom {
  static Future<Object?> customSignInDialog(
      BuildContext context, ValueChanged onClosed) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: 'Sign In',
        transitionDuration: const Duration(milliseconds: 400),
        transitionBuilder: (__, animation, _, child) {
          Tween<Offset> offsetTween = Tween(
            begin: const Offset(0, -1),
            end: Offset.zero,
          );
          return SlideTransition(
            position: offsetTween.animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          );
        },
        pageBuilder: (context, _, __) {
          return GestureDetector(
            onTap: () {
              // keyboard dismiss
              FocusScope.of(context).unfocus();
            },
            child: Center(
              child: Container(
                color: Colors.transparent,
                height: 635,
                child: Stack(
                  children: [
                    Container(
                      height: 620,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 32),
                      decoration: BoxDecoration(
                        color: DarkMode.getNeumorphismBackground(context)
                            .withOpacity(0.94),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        resizeToAvoidBottomInset: false,
                        body: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 34,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  'Access to 240+ hours of content. Learn design and code from scratch, building real apps with Flutter and Rive.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: DarkMode.getForegroundColor(context)
                                        .withOpacity(0.5),
                                  ),
                                ),
                              ),
                              const RiveSignInForm(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color:
                                          DarkMode.getListTileTitleColor(context)
                                              .withOpacity(0.2),
                                      thickness: 0.5,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      'OR',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: DarkMode.getListTileTitleColor(
                                                context)
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color:
                                          DarkMode.getListTileTitleColor(context)
                                              .withOpacity(0.2),
                                      thickness: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  'Sign in with Email, Apple, or Google',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: DarkMode.getListTileTitleColor(context)
                                        .withOpacity(0.6),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      Assets.emailButton,
                                      height: 54,
                                      width: 54,
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      Assets.appleButton,
                                      height: 54,
                                      width: 54,
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      Assets.googleButton,
                                      height: 54,
                                      width: 54,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: DarkMode.getBackgroundColor(context),
                          child: Icon(
                            Icons.close,
                            color: DarkMode.getForegroundColor(context),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }).then(onClosed);
  }
}
