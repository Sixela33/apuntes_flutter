import 'dart:core';

import 'package:autoguard/core/repository/TurnoRepository.dart';
import 'package:autoguard/presentation/entities/DataEntities/Turno.dart';
import 'package:autoguard/presentation/entities/Firebase.dart';
import 'package:autoguard/presentation/entities/Usuario.dart';
import 'package:autoguard/presentation/providers/userProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final agendaProvider = StateNotifierProvider<AgendaNotifier, AgendaInput>((ref) {
  
  final turnoRepository = ref.read(turnoRepositoryProvider);
  final user = ref.watch(userProvider);
  return AgendaNotifier(turnoRepository, user!);
  });

class AgendaInput {
  int? fromTime;
  int? toTime;
  int? interval;
  DateTime? dateFrom;
  DateTime? dateTo;
  List<bool>? days;

  AgendaInput() {
    days = List.generate(7, (index) => false);
  }

  AgendaInput copyWith({ int? fromTime, int? toTime, int? interval, DateTime? dateFrom, DateTime? dateTo, List<bool>? days }) {
    return AgendaInput()
      ..fromTime = fromTime ?? this.fromTime
      ..toTime = toTime ?? this.toTime
      ..interval = interval ?? this.interval
      ..dateFrom = dateFrom ?? this.dateFrom
      ..dateTo = dateTo ?? this.dateTo
      ..days = days ?? this.days;
  }
}

class AgendaNotifier extends StateNotifier<AgendaInput> {

Turnorepository _turnoRepository;
Usuario _user;


  AgendaNotifier( this._turnoRepository, this._user) : super(AgendaInput());

  void setFromTime(int? fromTime) {
    state = state.copyWith(fromTime: fromTime);
  }

  void setToTime(int? toTime) {
    state = state.copyWith(toTime: toTime);
  }

  void setInterval(int? interval) {
    state = state.copyWith(interval: interval);
  }

  void setDateFrom(DateTime? dateFrom) {
    state = state.copyWith(dateFrom: dateFrom);
  }

  void setDateTo(DateTime? dateTo) {
    state = state.copyWith(dateTo: dateTo);
  }

  void setDays(List<bool>? days) {
    state = state.copyWith(days: days);
  }

  Future<void> save() async {

    if (!validate()) {
      return;
    }

    var day = state.dateFrom;
    var until = state.dateTo;
    
    
    while(day!.isBefore(until!) || day.isAtSameMomentAs(until)) {
      if (state.days![day.weekday - 1]) {
        var fromTime = state.fromTime;
        while(fromTime! <= state.toTime!) {
        _turnoRepository.nuevoTurno(day.add(Duration(minutes: fromTime)), _user);
        fromTime += state.interval!;
      }
      }
      day = day.add(Duration(days: 1));
    }
  }
  void reset() {
    state = AgendaInput();
  }

  bool validate() {
    return state.fromTime != null && state.toTime != null && state.interval != null && state.dateFrom != null && state.dateTo != null && state.days!.contains(true);
  }

}
