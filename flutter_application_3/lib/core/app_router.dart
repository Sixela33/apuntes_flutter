import 'package:flutter_application_3/presentation/screens/movie_detail_screen.dart';
import 'package:flutter_application_3/presentation/screens/movies_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
    path: '/',
    builder: (context, state) => const MoviesScreen(),
    name: MoviesScreen.name
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) => const MovieDetailScreen(),
      name: MovieDetailScreen.name)
  ]
);