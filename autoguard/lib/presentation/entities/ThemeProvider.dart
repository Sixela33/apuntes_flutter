import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AppTheme = ThemeData(
  primaryColor: Color(0xFF8BC34A),
  primaryColorDark: Color(0xFF689F38),
  primaryColorLight: Color.fromARGB(255, 239, 255, 221),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: Color(0xFF8BC34A),
    shadowColor: Colors.transparent,
    elevation: 0.0,
    centerTitle: false,
    scrolledUnderElevation: 10.0,
    toolbarHeight: 72.0,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
    ),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 16.0),
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF8BC34A), width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF8BC34A), width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  ),
  
);
final themeNotifier = StateProvider((ref) => AppTheme);