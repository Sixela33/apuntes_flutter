import 'package:flutter/material.dart';
import 'package:flutter_application_4/presentation/screens/AppTutorialScreen.dart';
import 'package:flutter_application_4/presentation/screens/ButtonsScreen.dart';
import 'package:flutter_application_4/presentation/screens/ControlsScreen.dart';
import 'package:flutter_application_4/presentation/screens/CounterScreen.dart';
import 'package:flutter_application_4/presentation/screens/HomeScreen.dart';
import 'package:flutter_application_4/presentation/screens/PorogressScreen.dart';
import 'package:flutter_application_4/presentation/screens/SnackBarScreen.dart';
import 'package:flutter_application_4/presentation/screens/ThemeScreen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: HomeScreen.name,
      path: '/',
      builder: (context, state) => const HomeScreen()),
    GoRoute(
      name: ButtonsScreen.name,
      path: '/buttons',
      builder:(context, state) => const ButtonsScreen(),
    ),
    GoRoute(
      name: ControlsScreen.name,
      path: '/controls',
      builder:(context, state) => const ControlsScreen(),
    ),
    GoRoute(
      name: SnackBarScreen.name,
      path: '/snackBars',
      builder:(context, state) => const SnackBarScreen(),
    ),
    GoRoute(
      name: AppTutorialScreen.name,
      path: '/tutorial',
      builder:(context, state) => const AppTutorialScreen(),
    ),
    GoRoute(
      name: ProgressScreen.name,
      path: '/progress',
      builder:(context, state) => const ProgressScreen(),
    ),
     GoRoute(
      name: CounterScreen.name,
      path: '/counter',
      builder:(context, state) => CounterScreen(),
    ),
     GoRoute(
      name: ThemeScreen.name,
      path: '/counter',
      builder:(context, state) => const ThemeScreen(),
    ),
  ]
);