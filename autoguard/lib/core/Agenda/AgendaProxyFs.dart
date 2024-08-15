import 'dart:math';

import 'package:autoguard/presentation/providers/agendaProvider.dart';
import 'package:flutter/material.dart';

class AgendaProxyFs {

  AgendaProxyFs();

  @override
  void guardarAgenda(AgendaInput agenda) async {
    var day = agenda.dateFrom;
    var until = agenda.dateTo;
    
    
    while(day!.isBefore(until!)) {
      if (agenda.days![day.weekday - 1]) {
        var fromTime = agenda.fromTime;
        while(fromTime! < agenda.toTime!) {
        /* var cita = Cita(
          id: Random().nextInt(1000).toString(),
          idMedico: (await getActiveUser()).id!,
          fecha: day.add(Duration(minutes: fromTime)),
          libre: true
        ); */
        fromTime += agenda.interval!;
      }
      }
      day = day.add(Duration(days: 1));
    }
  }

  void guardarTurno() {
    throw UnimplementedError();
  }

  
}