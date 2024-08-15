import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/appTheme.dart';
import 'package:flutter_application_4/presentation/providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeScreen extends StatelessWidget {
  static String name = "Theme Selector";
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ThemeScreen();
  }
}

class _ThemeScreen extends ConsumerWidget {
  _ThemeScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context, ref) {
    final selectedColor = ref.watch(themeNotifierProvider);

    return ListView.builder(
      itemCount: colorList.length, 
      itemBuilder: (context, index) {
        return RadioListTile(
          title: Text("Color $index"),
          value: index, 
          groupValue: selectedColor, 
          onChanged: (value) {
            ref.read(themeNotifierProvider.notifier).changeColorTheme(value ?? 0);
          }
          );
        },
      );
  }
}