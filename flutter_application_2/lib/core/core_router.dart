import 'package:flutter_application_2/presentation/screens/home_screen.dart';
import 'package:flutter_application_2/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/',
    builder: (context, state) => const LoginScreen(),
    name: LoginScreen.name,
    ),
    GoRoute(path: '/home-screen',
    builder: (context, state) => HomeScreen(username: state.extra as String),
    name: HomeScreen.name,
    )
  ]
);
