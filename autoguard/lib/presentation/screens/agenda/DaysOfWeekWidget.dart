import 'package:autoguard/presentation/providers/agendaProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DaysOfWeekWidget extends ConsumerWidget {
 
 
  @override
  Widget build(BuildContext context, ref) {

 List<bool>? _selectedDays = ref.watch(agendaProvider).days;


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 7; i++)
          CheckboxListTile(
            title: Text(_getDayOfWeekName(i)),
            value: _selectedDays?[i],
            onChanged: (value) {
              ref.read(agendaProvider.notifier).setDays(_selectedDays?..[i] = value!);
            },
          ),
      ],
    );
  }

  String _getDayOfWeekName(int index) {
    switch (index) {
      case 0:
      return 'Lunes';
      case 1:
      return 'Martes';
      case 2:
      return 'Miércoles';
      case 3:
      return 'Jueves';
      case 4:
      return 'Viernes';
      case 5:
      return 'Sábado';
      case 6:
      return 'Domingo';
      default:
      return '';
    }
    }
}