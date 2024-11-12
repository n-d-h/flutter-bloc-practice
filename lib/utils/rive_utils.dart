import 'dart:ui';

import 'package:bloc_learner/common/assets.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveUtils {
  static StateMachineController getRiveController(Artboard artBoard,
      {String stateMachineName = "State Machine 1"}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artBoard, stateMachineName);
    artBoard.addController(controller!);
    return controller;
  }
}

class RiveBottomItem {
  final String artBoard, stateMachineName, title, src;
  late SMIBool? input;

  RiveBottomItem({
    required this.artBoard,
    required this.stateMachineName,
    required this.title,
    required this.src,
    this.input,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveBottomItem> bottomNavs = [
  RiveBottomItem(
    artBoard: "CHAT",
    stateMachineName: "CHAT_Interactivity",
    title: "Chat",
    src: Assets.riveIcons,
  ),
  RiveBottomItem(
    artBoard: "SEARCH",
    stateMachineName: "SEARCH_Interactivity",
    title: "Search",
    src: Assets.riveIcons,
  ),
  RiveBottomItem(
    artBoard: "BELL",
    stateMachineName: "BELL_Interactivity",
    title: "Notification",
    src: Assets.riveIcons,
  ),
  RiveBottomItem(
    artBoard: "TIMER",
    stateMachineName: "TIMER_Interactivity",
    title: "Time",
    src: Assets.riveIcons,
  ),
  RiveBottomItem(
    artBoard: "USER",
    stateMachineName: "USER_Interactivity",
    title: "Profile",
    src: Assets.riveIcons,
  ),
];

List<RiveBottomItem> navButtons = [
  RiveBottomItem(
    artBoard: "HOME",
    stateMachineName: "HOME_interactivity",
    title: "Home",
    src: Assets.riveIcons,
  ),
  RiveBottomItem(
    artBoard: "SEARCH",
    stateMachineName: "SEARCH_Interactivity",
    title: "Search",
    src: Assets.riveIcons,
  ),
  RiveBottomItem(
    artBoard: "LIKE/STAR",
    stateMachineName: "STAR_Interactivity",
    title: "Favorites",
    src: Assets.riveIcons,
  ),
  RiveBottomItem(
    artBoard: "CHAT",
    stateMachineName: "CHAT_Interactivity",
    title: "Chat",
    src: Assets.riveIcons,
  ),
];

List<RiveBottomItem> navButtons2 = [
  RiveBottomItem(
    artBoard: "TIMER",
    stateMachineName: "TIMER_Interactivity",
    title: "Time",
    src: Assets.riveIcons,
  ),
  RiveBottomItem(
    artBoard: "BELL",
    stateMachineName: "BELL_Interactivity",
    title: "Notification",
    src: Assets.riveIcons,
  )
];

class Course {
  final String title;
  final String description;
  final String icon;
  final Color bgColors;

  Course({
    required this.title,
    this.description = 'Building and animate an IOS app from scratch',
    this.icon = Assets.riveIOSIcon,
    this.bgColors = const Color(0xFF7553F6),
  });
}

List<Course> courses = [
  Course(title: 'Animation in SwiftUI'),
  Course(
    title: 'Animated in Flutter',
    icon: Assets.riveCodeIcon,
    bgColors: const Color(0xFF80A4FF),
  ),
  Course(
    title: 'Flutter made by Google',
    icon: Assets.googleButton,
    bgColors: Colors.deepOrangeAccent,
  ),
];

List<Course> recentCourse = [
  Course(title: "State Machine"),
  Course(
    title: 'Animated Menu',
    bgColors: const Color(0xFF80A4FF),
    icon: Assets.riveCodeIcon,
  ),
  Course(title: 'Flutter with Rive'),
  Course(
    title: 'Animated in Flutter',
    bgColors: const Color(0xFF80A4FF),
    icon: Assets.riveCodeIcon,
  )
];
