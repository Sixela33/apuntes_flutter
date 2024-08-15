import 'package:autoguard/core/repository/TurnoRepository.dart';
import 'package:autoguard/core/repository/UserRepository.dart';
import 'package:autoguard/presentation/entities/DataEntities/EstadoTurno.dart';
import 'package:autoguard/presentation/entities/DataEntities/Medic.dart';
import 'package:autoguard/presentation/entities/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Turno {
  final String id;
  final DateTime fechaHora;
  final String? razonConsulta;
  final EstadoTurno estado;
  final String? especialidadSeleccionada;
  final String medicoName;
  final String medicoID;
  final String? pacienteID;
  final String? diagnostico;
  final String? tratamiento;

  Turno({
    required this.id,
    required this.fechaHora,
    this.razonConsulta,
    required this.estado,
    required this.medicoName,
    required this.medicoID,
    this.pacienteID,
    this.especialidadSeleccionada,
    this.diagnostico,
    this.tratamiento
  });

  factory Turno.fromMap(Map<String, dynamic> data, String documentId) {

    return Turno(
      id: documentId,
      fechaHora: (data['fecha_hora'] as Timestamp).toDate(),
      razonConsulta: data['razon_consulta'],
      estado: EstadoTurno.values.firstWhere((e) => e.toString() == data['estado']),
      medicoName: data['medico_name'],
      medicoID: data['medico_id'],
      pacienteID: data['paciente_id'],
      especialidadSeleccionada: data['especialidad'],
      diagnostico: data['diagnostico'],
      tratamiento: data['tratamiento']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fecha_hora': fechaHora,
      'razon_consulta': razonConsulta,
      'estado': estado.toString(),
      'medico_name': medicoName,
      'medico_id': medicoID,
      'paciente_id': pacienteID,
      'especialidad': especialidadSeleccionada,
    };
  }
}

final detalleTurnoProvider = FutureProvider.autoDispose.family<DetalleTurno, String>((ref, turnoId) async {
  final UserRepository = ref.watch(userRepositoryProvider);
  final Turnorepository = ref.watch(turnoRepositoryProvider);
  final turno = await Turnorepository.getTurno(turnoId);
  final usuario = await UserRepository.getUsuario(turno.pacienteID!);
  return DetalleTurno.fromUserAndTurno(usuario, turno);
});

class DetalleTurno {
  final String id;
  final DateTime fechaHora;
  final String? razonConsulta;
  final EstadoTurno estado;
  final String especialidadSeleccionada;
  final String medicoName;
  final String medicoId;
  final String emailPaciente;
  final String idPaciente;
  final String? diagnostico;
  final String? tratamiento;
  final String? nombrePaciente;


  DetalleTurno({
    required this.id,
    required this.fechaHora,
    this.razonConsulta,
    required this.estado,
    required this.medicoName,
    required this.emailPaciente,
    required this.especialidadSeleccionada,
    required this.idPaciente,
    required this.medicoId,
    this.diagnostico,
     this.tratamiento,
    this.nombrePaciente
  });

 factory DetalleTurno.fromUserAndTurno(Usuario user, Turno turno) {
    return DetalleTurno(
      idPaciente: user.id,
      medicoId: turno.medicoID,
      id: turno.id,
      fechaHora: turno.fechaHora,
      razonConsulta: turno.razonConsulta,
      estado: turno.estado,
      medicoName: turno.medicoName,
      emailPaciente: user.email!,
      especialidadSeleccionada: turno.especialidadSeleccionada!,
      diagnostico: turno.diagnostico,
      tratamiento: turno.tratamiento,
      nombrePaciente: user.nombre
    );
  }
}