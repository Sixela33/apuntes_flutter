import 'package:flutter_application_6/presentation/screens/HomeScreen.dart';
import 'package:flutter_application_6/presentation/screens/MoviesScreen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: HomeScreen.name,
      path: '/',
      builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: MoviesScreen.name,
        path: '/movies',
        builder: (context, state) => const MoviesScreen(),
      )
      
  ]
);