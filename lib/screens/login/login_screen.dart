import 'package:bloc_learner/widgets/login_widgets/button_login.dart';
import 'package:bloc_learner/widgets/login_widgets/card_glass.dart';
import 'package:bloc_learner/widgets/login_widgets/fade_animation.dart';
import 'package:bloc_learner/widgets/login_widgets/text_field_with_validator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                    "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"),
                fit: BoxFit.cover,
                // colorFilter: ColorFilter.mode(
                //   Colors.white.withOpacity(0.8),
                //   BlendMode.dstATop,
                // ),
              ),
            ),
            child: Column(
              children: [
                const CardGlass(),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 60, horizontal: 0),
                    child: Column(
                      children: [
                        TextFieldWithValidator(
                          hintText: 'Enter Username',
                          validator: 'Username is required !!!',
                          textInputAction: TextInputAction.next,
                          onChange: (value) {
                            print(value);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFieldWithValidator(
                          hintText: 'Password',
                          isSecured: true,
                          validator: 'Password is required !!!',
                          textInputAction: TextInputAction.done,
                          onChange: (value) {
                            print(value);
                          },
                        ),
                        FadeAnimation(
                          delay: 1.5,
                            child: ButtonLogin(formKey: _formKey)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
