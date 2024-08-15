import 'package:autoguard/core/appRouter.dart';
import 'package:autoguard/presentation/entities/ThemeProvider.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  OpenAI.apiKey = dotenv.env['OPEN_AI_API_KEY'] ?? '';

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeNotifier);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig:appRouter,
      theme: theme,
    );
  }
}
