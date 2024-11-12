import 'dart:math';

import 'package:bloc_learner/common/assets.dart';
import 'package:bloc_learner/screens/rive_animation/rive_home_screen.dart';
import 'package:bloc_learner/screens/rive_animation/rive_side_menu.dart';
import 'package:bloc_learner/utils/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveEntry extends StatefulWidget {
  const RiveEntry({super.key});

  @override
  State<RiveEntry> createState() => _RiveEntryState();
}

class _RiveEntryState extends State<RiveEntry>
    with SingleTickerProviderStateMixin {
  late SMIBool search;
  late SMIBool isSideBarClosed;
  bool isSideClosed = true;
  RiveBottomItem selected = bottomNavs.first;

  late AnimationController controller;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      // swipe to right to open side menu
      // swipe to left to close side menu
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! < 0) {
          if (!isSideClosed) {
            isSideBarClosed.value = true;
            controller.reverse();
            setState(() {
              isSideClosed = true;
            });
          }
        } else {
          if (isSideClosed) {
            isSideBarClosed.value = false;
            controller.forward();
            setState(() {
              isSideClosed = false;
            });
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF17203A),
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              width: size.width * 0.8,
              left: isSideClosed ? -size.width * 0.8 : 0,
              height: size.height,
              child: const RiveSideMenu(),
            ),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(animation.value - 30 * animation.value * pi / 180),
              child: Transform.translate(
                offset: Offset(animation.value * size.width * 0.74, 0),
                child: Transform.scale(
                  scale: scaleAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(isSideClosed ? 0 : 24),
                    child: RiveHomeScreen(isSideClosed: isSideClosed),
                  ),
                ),
              ),
            ),
            menuBtn(),
          ],
        ),
        bottomNavigationBar: Transform.translate(
          offset: Offset(0, 100 * animation.value),
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 30),
            decoration: BoxDecoration(
                color: const Color(0xFF17203A).withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(24))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  bottomNavs.length,
                  (index) => GestureDetector(
                    onTap: () {
                      bottomNavs[index].input!.change(true);
                      if (selected != bottomNavs[index]) {
                        setState(() {
                          selected = bottomNavs[index];
                        });
                      }
                      Future.delayed(const Duration(seconds: 1), () {
                        bottomNavs[index].input!.change(false);
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 2),
                          height: 4,
                          width: selected == bottomNavs[index] ? 20 : 0,
                          decoration: const BoxDecoration(
                            color: Color(0xFF81D4FF),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        SizedBox.square(
                          dimension: 36,
                          child: Opacity(
                            opacity: selected == bottomNavs[index] ? 1 : 0.5,
                            child: RiveAnimation.asset(
                              bottomNavs.first.src,
                              artboard: bottomNavs[index].artBoard,
                              onInit: (artBoard) {
                                StateMachineController controller =
                                    RiveUtils.getRiveController(artBoard,
                                        stateMachineName:
                                            bottomNavs[index].stateMachineName);
                                bottomNavs[index].input =
                                    controller.findSMI("active") as SMIBool;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget menuBtn() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      left: isSideClosed ? 0 : 0.72 * MediaQuery.of(context).size.width - 40,
      top: 16,
      curve: Curves.fastOutSlowIn,
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            isSideBarClosed.value = !isSideBarClosed.value;
            if (isSideClosed) {
              controller.forward();
            } else {
              controller.reverse();
            }
            setState(() {
              isSideClosed = isSideBarClosed.value;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: RiveAnimation.asset(
              Assets.riveMenuButton,
              onInit: (artBoard) {
                StateMachineController controller = RiveUtils.getRiveController(
                  artBoard,
                  stateMachineName: "State Machine",
                );
                isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
                isSideBarClosed.value = true;
              },
            ),
          ),
        ),
      ),
    );
  }
}
