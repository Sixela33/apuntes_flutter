import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/appRouter.dart';
import 'package:flutter_application_4/core/appTheme.dart';
import 'package:flutter_application_4/presentation/providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  ProviderScope(
    child: MainApp(),
  );
}

class MainApp extends ConsumerWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: theme.getTheme(),
    );
  }
}
