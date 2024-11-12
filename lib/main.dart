import 'dart:developer';

import 'package:bloc_learner/bloc_providers.dart';
import 'package:bloc_learner/routes.dart';
import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

String initialRoute = Routes.loginScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  log('Shared Preferences: ');
  prefs.getKeys().forEach((key) {
    log(' - $key: ${prefs.get(key)}');
  });

  if (prefs.containsKey('isLogged') && prefs.getBool('isLogged') == true) {
    initialRoute = Routes.home;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: Blocs.blocProviders,
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Flutter Bloc Learner',
          debugShowCheckedModeBanner: false,
          themeMode: DarkMode.getThemeMode(context),
          darkTheme: ThemeClass.darkTheme,
          theme: ThemeClass.lightTheme,
          initialRoute: initialRoute,
          onGenerateRoute: (settings) => Routes.getRoute(settings),
        );
      }),
    );
  }
}
