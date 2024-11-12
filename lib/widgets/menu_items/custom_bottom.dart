import 'package:bloc_learner/utils/color_utils.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet {
  static void showBottomSheet(
      {required BuildContext context,
      required Widget child,
      required String title,
      double? height}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        return Container(
          height: height ?? MediaQuery.of(context).size.height / 2,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    gradient: Gradients.defaultGradientBackground,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(child: child)
            ],
          ),
        );
      },
    );
  }
}
