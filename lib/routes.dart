import 'dart:developer';

import 'package:bloc_learner/screens/home_screen.dart';
import 'package:bloc_learner/screens/login/login_screen.dart';
import 'package:bloc_learner/screens/play_ground/calculator_screen.dart';
import 'package:bloc_learner/screens/play_ground/counter_screen.dart';
import 'package:bloc_learner/screens/play_ground/favorite_app_screen.dart';
import 'package:bloc_learner/screens/play_ground/image_picker_screen.dart';
import 'package:bloc_learner/screens/play_ground/list_todo_screen.dart';
import 'package:bloc_learner/screens/play_ground/menu_list_screen.dart';
import 'package:bloc_learner/screens/play_ground/post_screen.dart';
import 'package:bloc_learner/screens/play_ground/shimmer_screen.dart';
import 'package:bloc_learner/screens/play_ground/switch_screen.dart';
import 'package:bloc_learner/screens/rive_animation/rive_entry.dart';
import 'package:bloc_learner/screens/rive_animation/rive_intro.dart';
import 'package:bloc_learner/screens/ui_learn/flutter_way/paralax/paralax.dart';
import 'package:bloc_learner/screens/ui_learn/mitch_koko/minimal_weather.dart';
import 'package:bloc_learner/utils/page_trasition_utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static const String home = '/';
  static const String counterScreen = '/counter';
  static const String switchScreen = '/switch';
  static const String imagePickerScreen = '/image-picker';
  static const String listTodoScreen = '/list-todo';
  static const String favoriteAppScreen = '/favorite-app';
  static const String postScreen = '/post';
  static const String calculatorScreen = '/calculator';
  static const String menuListScreen = '/menu-list';
  static const String shimmerScreen = '/shimmer';
  static const String loginScreen = '/login';
  static const String riveIntroScreen = '/rive-intro';
  static const String riveHomeScreen = '/rive-home';
  static const String paralaxScreen = '/flutter-way/paralax';
  static const String minimalWeatherScreen = '/mitch-koko/minimal-weather';

  static Route<dynamic> getRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case home:
        page = const HomeScreen();
        break;
      case loginScreen:
        page = const LoginScreen();
        break;
      case paralaxScreen:
        page = const Paralax();
        break;
      case minimalWeatherScreen:
        page = const MinimalWeather();
        break;
      case riveIntroScreen:
        page = const RiveIntro();
        break;
      case riveHomeScreen:
        page = const RiveEntry();
        break;
      case shimmerScreen:
        page = const ShimmerScreen();
        break;
      case menuListScreen:
        page = const MenuListScreen();
        break;
      case calculatorScreen:
        page = const CalculatorScreen();
        break;
      case postScreen:
        page = const PostScreen();
        break;
      case favoriteAppScreen:
        page = const FavoriteAppScreen();
        break;
      case listTodoScreen:
        page = const ListToDoScreen();
        break;
      case imagePickerScreen:
        page = const ImagePickerScreen();
        break;
      case switchScreen:
        page = const SwitchScreen();
        break;
      case counterScreen:
        page = const CounterScreen();
        break;
      default:
        page = const LoginScreen();
        break;
    }
    log('Route: ${settings.name}');
    log('Widget: $page');
    log('Arguments: ${settings.arguments}');
    return CustomPageTransition.transition(page, settings);
  }

  static Future getBack(BuildContext context,
      {List<String>? routes, dynamic result}) async {
    if (routes != null && routes.isNotEmpty) {
      return Navigator.popUntil(
          context, (route) => routes.contains(route.settings.name));
    }
    return Navigator.pop(context, result);
  }

  static Future goToAndKill(BuildContext context, String routeName,
      {Object? arguments, PageTransitionType? transitionType}) async {
    Map<String, dynamic> mapDataRoute = {};
    mapDataRoute = {
      "transitionType": transitionType ?? PageTransitionType.rightToLeft
    };
    if (arguments != null) {
      arguments = arguments as Map<String, dynamic>;
      mapDataRoute.addAll(arguments);
    }
    return Navigator.pushNamedAndRemoveUntil(
        context, routeName, (route) => false,
        arguments: mapDataRoute);
  }

  static Future goTo(BuildContext context, String routeName,
      {Object? arguments, PageTransitionType? transitionType}) async {
    // Default to a right-to-left transition if none provided
    transitionType ??= PageTransitionType.rightToLeft;

    // If arguments is a String, push the route with that argument
    if (arguments is String) {
      return Navigator.pushNamed(
        context,
        routeName,
        arguments: arguments,
      );
    }

    // If arguments is a Map, handle it as route data
    Map<String, dynamic>? mapDataRoute = {};
    if (arguments is Map<String, dynamic>) {
      mapDataRoute.addAll(arguments);
    }

    // Add the transition type to the route data
    mapDataRoute['transitionType'] = transitionType;

    // Finally, navigate with the constructed mapDataRoute
    return Navigator.pushNamed(
      context,
      routeName,
      arguments: mapDataRoute.isNotEmpty
          ? mapDataRoute
          : null, // Pass null if the map is empty
    );
  }
}
