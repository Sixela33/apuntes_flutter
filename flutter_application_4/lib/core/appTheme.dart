import 'package:flutter/material.dart';

final List<Color> colorList = [
  Colors.green,
  Colors.red
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({this.selectedColor = 0, this.isDarkMode = false})
  :assert(selectedColor >= 0, 'selected color must be bigger than 0'),
  assert(selectedColor < colorList.length, '');

  ThemeData getTheme() {
    return ThemeData(
      colorSchemeSeed: colorList[selectedColor],
      brightness: isDarkMode ? Brightness.dark : Brightness.light
    );
  }

  AppTheme copyWith(int? selectedColor, bool? isDarkMode) {
    return AppTheme(
      selectedColor:  selectedColor ?? this.selectedColor,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}