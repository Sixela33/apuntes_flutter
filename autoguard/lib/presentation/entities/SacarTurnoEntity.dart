import 'package:autoguard/presentation/entities/Firebase.dart';
import 'package:autoguard/presentation/entities/DataEntities/Medic.dart';
import 'package:autoguard/presentation/providers/dbProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SacarTurnoEntity {
  late String especialidadSeleccionada;
  late String inputUsuarioRazonConsulta;
  late Medic medicoSeleccionado;
  late DateTime fechaSeleccionada;
  List<Medic> medicosDisponibles = [];

  void setEspecialidadSeleccionada(String id) async {
    this.especialidadSeleccionada = id;
  }

  void setInputRazonConsulta(String razon) {
    this.inputUsuarioRazonConsulta = razon;
  }

  void setFechaSeleccionada(DateTime fecha) {
    this.fechaSeleccionada = fecha;
  }

  Future<void> setMedicoSeleccionado(Medic medico) async {
    medicoSeleccionado = medico;
    return;
  }

  void setTime (TimeOfDay time) {
     fechaSeleccionada = DateTime(
      fechaSeleccionada.year,
      fechaSeleccionada.month,
      fechaSeleccionada.day,
      time.hour,
      time.minute,
      fechaSeleccionada.second,
      fechaSeleccionada.millisecond,
      fechaSeleccionada.microsecond,
    );
  }

}


