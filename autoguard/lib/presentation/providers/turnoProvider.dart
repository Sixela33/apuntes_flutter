import 'package:autoguard/presentation/entities/DataEntities/Medic.dart';
import 'package:autoguard/presentation/entities/SacarTurnoEntity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final turnoProvider = StateNotifierProvider<turnoNotifier, SacarTurnoEntity>((ref) => turnoNotifier());

class turnoNotifier extends StateNotifier<SacarTurnoEntity> {
  turnoNotifier() : super(SacarTurnoEntity());

  void setEspecialidadSeleccionada(String id) async {
    state.setEspecialidadSeleccionada(id);
    state = state;
  }

  void setInputRazonConsulta(String razon) {
    state.setInputRazonConsulta(razon);
    state = state;
  }

  void setFechaSeleccionada(DateTime fecha) {
    state.setFechaSeleccionada(fecha);
    state = state;
  }

  Future<void> setMedicoSeleccionado(Medic medico) async {
    await state.setMedicoSeleccionado(medico);
    return;
  }

  void setTime (time) {
    state.setTime(time);
  }

  SacarTurnoEntity getState() {
    return state;
  }

}

