import 'dart:ui';

import 'package:autoguard/presentation/entities/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeSlot extends ConsumerWidget {
  final String timeLabel;
  final bool isSelected;
  final bool isReserved;
  final VoidCallback? onTap;

  const TimeSlot({
    required this.timeLabel,
    required this.isSelected,
    required this.isReserved,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, ref) {
    final themeProvider = ref.watch(themeNotifier);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isReserved ? Colors.grey : isSelected ? themeProvider.primaryColorLight : themeProvider.primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          timeLabel,
          style: TextStyle(
            color: isReserved ? Colors.black45 : Colors.black,
          ),
        ),
      ),
    );
  }
}