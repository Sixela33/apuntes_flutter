import 'package:autoguard/presentation/entities/ThemeProvider.dart';
import 'package:autoguard/presentation/screens/agenda/DaysOfWeekWidget.dart';
import 'package:autoguard/presentation/screens/agenda/InputDateWidget.dart';
import 'package:autoguard/presentation/screens/agenda/InputTimeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgendaScreen extends ConsumerWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agenda',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: theme.primaryColor,
      ),
      body: PageView(
        children: [
          InputDateWidget(),
          DaysOfWeekWidget(),
          InputTimeWidget(),
        ],
      ),
    );
  }
}
