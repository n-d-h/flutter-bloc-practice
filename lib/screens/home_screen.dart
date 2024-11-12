import 'dart:io';

import 'package:bloc_learner/bloc/switch/switch_bloc.dart';
import 'package:bloc_learner/common/assets.dart';
import 'package:bloc_learner/routes.dart';
import 'package:bloc_learner/utils/color_utils.dart';
import 'package:bloc_learner/widgets/flutter_way/bottom_home/bottom_home_item.dart';
import 'package:bloc_learner/widgets/list_button.dart';
import 'package:bloc_learner/widgets/login_widgets/glass_morphism.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const duration = 200;
    const delay = 200;
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => exit(0),
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Bloc Learner'),
          actions: [
            // logout button
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('Do you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.clear();
                            if (context.mounted) {
                              Navigator.of(context).pop(false);
                              Routes.goToAndKill(context, Routes.loginScreen);
                            }
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: GridView.count(
          mainAxisSpacing: 10,
          padding: const EdgeInsets.all(20),
          childAspectRatio: 7,
          crossAxisCount: 1,
          children: [
            const ListButton(
              title: 'Counter',
              route: Routes.counterScreen,
              delay: Duration(milliseconds: duration),
            ),
            const ListButton(
              title: "Dark mode",
              route: Routes.switchScreen,
              delay: Duration(milliseconds: duration + delay),
            ),
            const ListButton(
              title: "Image Picker",
              route: Routes.imagePickerScreen,
              delay: Duration(milliseconds: duration + delay * 2),
            ),
            const ListButton(
              title: 'List todo',
              route: Routes.listTodoScreen,
              delay: Duration(milliseconds: duration + delay * 3),
            ),
            const ListButton(
              title: 'Favorite apps',
              route: Routes.favoriteAppScreen,
              delay: Duration(milliseconds: duration + delay * 4),
            ),
            const ListButton(
              title: 'Post Screen',
              route: Routes.postScreen,
              delay: Duration(milliseconds: duration + delay * 5),
            ),
            const ListButton(
              title: "Calculator",
              route: Routes.calculatorScreen,
              delay: Duration(milliseconds: duration + delay * 6),
            ),
            const ListButton(
              title: "Menu list",
              route: Routes.menuListScreen,
              delay: Duration(milliseconds: duration + delay * 7),
            ),
            const ListButton(
              title: "Shimmer",
              route: Routes.shimmerScreen,
              delay: Duration(milliseconds: duration + delay * 8),
            ),
            const ListButton(
              title: "Rive Intro",
              route: Routes.riveIntroScreen,
              isContainerAnimated: true,
              isTextAnimated: true,
              delay: Duration(milliseconds: duration + delay * 9),
            ),
            ListButton(
              delay: const Duration(milliseconds: duration + delay * 10),
              title: 'Flutter Way',
              fontWeight: FontWeight.bold,
              backgroundColors: [
                HexColor.fromHex("#4568DC"),
                HexColor.fromHex('#B06AB3'),
              ],
              textColors: const [Colors.white60],
              isDropdownButton: true,
              onPressed: () {
                FlutterWay.flutterWayBottomSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
