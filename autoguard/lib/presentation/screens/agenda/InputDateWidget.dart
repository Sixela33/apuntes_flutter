import 'dart:math';

import 'package:autoguard/presentation/providers/agendaProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

DateFormat formatFecha = DateFormat("dd-MM-yyyy");

class InputDateWidget extends ConsumerWidget {
  

  TextEditingController _desdeController = TextEditingController();
  TextEditingController _hastaController = TextEditingController();
  


  @override
  Widget build(BuildContext context, ref) {

    DateTime? _selectedDateFrom = ref.watch(agendaProvider).dateFrom;
    DateTime? _selectedDateTo = ref.watch(agendaProvider).dateTo;

    var _errorText = isDateRangeValid(_selectedDateFrom, _selectedDateTo) ? null : 'La fecha desde debe ser anterior a la fecha hasta';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextField(
            readOnly: true,
            decoration: InputDecoration(
              icon: Icon(Icons.calendar_today),
              labelText: 'Ingresa la fecha desde',
            ),
            controller: _desdeController,
            onTap: () async {
              final DateTime? date = await showDatePicker(
                context: context,
                initialDate: _selectedDateFrom ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              );

              if (date != null) {
                _desdeController.text = formatFecha.format(date);
                ref.read(agendaProvider.notifier).setDateFrom(date);
              }
            },
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 40, 20, 40),
          child: TextField(
            readOnly: true,
            decoration: InputDecoration(
              icon: Icon(Icons.calendar_today),
              labelText: 'Ingresa la fecha hasta',
              errorText: _errorText,
            ),
            controller: _hastaController,
            onTap: () async {
              final DateTime? date = await showDatePicker(
                context: context,
                initialDate: _selectedDateTo ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              );

              if (date != null) {
                _hastaController.text = formatFecha.format(date);
                ref.read(agendaProvider.notifier).setDateTo(date);
              }
            },
          ),
        ),
      ],
    );
  }
}

bool isDateRangeValid(DateTime? from, DateTime? to) {
  if (from == null || to == null) {
    return true;
  }
  return from.isBefore(to);
}
