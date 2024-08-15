import 'package:autoguard/presentation/entities/DataEntities/EspecialidadMedica.dart';
import 'package:autoguard/presentation/entities/DataEntities/Turno.dart';
import 'package:autoguard/presentation/entities/Firebase.dart';
import 'package:autoguard/presentation/entities/DataEntities/Medic.dart';
import 'package:autoguard/presentation/entities/DataEntities/ObraSocial.dart';
import 'package:autoguard/presentation/providers/userProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseNotifierProvider = StateNotifierProvider<DatabaseNotifier, Database>((ref) => DatabaseNotifier(ref));

class DatabaseNotifier extends StateNotifier<Database> {
  final Ref ref;

  DatabaseNotifier(this.ref) : super(Database());

  Future<void> registerWithEmailAndPassword(String email, String password, List<ObraSocial> obrasSociales) async {
    await state.registerWithEmailAndPassword(email, password, obrasSociales);
  }

  Future<void> registerWithEmailAndPasswordDoctor(String email, String password, String nombre, List<ObraSocial> obrasSociales, List<EspecialidadMedica> especialidades) async {
    await registerWithEmailAndPasswordDoctor(email, password, nombre, obrasSociales, especialidades);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await state.signInWithEmailAndPassword(email, password);
    await ref.read(userProvider.notifier).login();
  }

  Future<void> addObraSocial(String nombreObraSocial) async {
    await state.addObraSocial(nombreObraSocial);
  }

  Future<List<ObraSocial>> getObrasSociales() async {
    return state.getObrasSociales();
  }

  Future<List<EspecialidadMedica>> getEspecialidades() async {
    return state.getEspecialidades();
  }

  Future<List<Medic>> getMedicosByEspecialidad(String especialidad, String obraSocial) async {
    return state.getMedicosOfEspecialidad(especialidad, obraSocial);
  }

  Future<List<Turno>> getTurnosUsuario() async {
    return state.getTurnosPorUsuario();
  }

  Future<List<Turno>> getTurnosPorMedico(String medicoID) async {
    return state.getTurnosPorMedico(medicoID);
  }

  Future<List<Turno>> getTurnosPorMedicoYFecha(String medicoId, DateTime fechaSeleccionada) async {
    return state.getTurnosPorMedicoYFecha(medicoId, fechaSeleccionada);
  }

  Future<void> cancelarTurno(String id) async {
    await state.cancelarTurno(id);
  }
}



