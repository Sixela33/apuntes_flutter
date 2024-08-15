import 'package:autoguard/presentation/entities/DataEntities/EstadoTurno.dart';
import 'package:autoguard/presentation/entities/DataEntities/Turno.dart';
import 'package:autoguard/presentation/entities/DetalleClinico.dart';
import 'package:autoguard/presentation/entities/Firebase.dart';
import 'package:autoguard/presentation/entities/Usuario.dart';
import 'package:autoguard/presentation/providers/turnoProvider.dart';
import 'package:autoguard/presentation/providers/userProvider.dart';
import 'package:autoguard/presentation/providers/utilProviders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Turnorepository {
  final FirebaseFirestore _firestore;
  Turnorepository(this._firestore);

  Future<void> finalizarTurno(String id, String diagnostico, String tratamiento) async {
    await _firestore.collection('turnos').doc(id).update({'estado': EstadoTurno.finalizado.toString(),
    'diagnostico': diagnostico, 'tratamiento': tratamiento});
  }

  Future<Turno> getTurno(String id) async {
    final snapshot = await _firestore.collection('turnos').doc(id).get();
    return Turno.fromMap(snapshot.data()!, snapshot.id);
  }

  Future<List<DetalleClinico>> getHistoriaClinica(String userId) async {
    return _firestore.collection("turnos")
    .withConverter(fromFirestore: (snapshot, _) => 
      DetalleClinico.fromMap(snapshot.data()!), toFirestore: (detalle, _) => detalle.toMap())
    .where("paciente_id", isEqualTo: userId)
    .where("estado", isEqualTo: EstadoTurno.finalizado.toString())
    .where("diagnostico", isNull: false)
    .orderBy("fecha_hora", descending: true)
    .get().then((value) => value.docs.map((e) => e.data()).toList());
}

Future<void> cancelarTurno(DetalleTurno detalle) async {

  _firestore.collection('turnos').doc(detalle.id).update({'estado': EstadoTurno.cancelado.toString()})
  .then((value) => nuevoTurnoFromDetalle(detalle));
  

}

Future<void> nuevoTurno(DateTime fecha, Usuario medico) {
  return _firestore.collection('turnos').add({
    'fecha_hora': fecha,
    'medico_id': medico.id,
    'medico_name': medico.nombre,
    'estado': EstadoTurno.libre.toString()
  });
}

Future<void> nuevoTurnoFromDetalle(DetalleTurno detalle) {
  return _firestore.collection('turnos').add({
    'fecha_hora': detalle.fechaHora,
    'medico_id': detalle.medicoId,
    'medico_name': detalle.medicoName,
    'estado': EstadoTurno.libre.toString()
  });
}

  Future<void> calificarTurno(String turnoId, double puntaje) async{

    final turno = await _firestore.collection('turnos').withConverter(fromFirestore: (snapshot, _) => Turno.fromMap(snapshot.data()!, snapshot.id), toFirestore: (turno, _) => turno.toMap()).doc(turnoId).get();
    final medico = await _firestore.collection('users').withConverter(fromFirestore: (snapshot, _) => Usuario.fromMap(snapshot.data()!), toFirestore: (usuario, _) => Map()).doc(turno.data()?.medicoID).get();

    await _firestore.collection("users").doc(medico.id).update( {
      "rating": {
        "puntaje": medico.data()!.rating != null ? (medico.data()?.rating!.puntaje)! + puntaje : puntaje,
        "cantidad": medico.data()!.rating != null ? (medico.data()!.rating!.cantidad) + 1 : 1
      }
    });

  }
}

final turnoRepositoryProvider = Provider((ref) => Turnorepository(ref.read(firebaseFirestoreProvider)));

final turnosQueryProvider = Provider.autoDispose.family<Query<Turno>, Set<EstadoTurno>>((ref, filters) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final user = ref.read(userProvider);
  var turnosQuery = firestore.collection("turnos").withConverter<Turno>(fromFirestore: (snapshot, _) => Turno.fromMap(snapshot.data()!, snapshot.id), toFirestore: (turno, _) => turno.toMap())
  .where("medico_id", isEqualTo: user!.id);
  if (filters.isNotEmpty) {
    turnosQuery = turnosQuery.where("estado", whereIn: filters.map((e) => e.toString()));
  }
  turnosQuery = turnosQuery.orderBy("fecha_hora", descending: false);

  return turnosQuery;
} );

final getDiasDisponiblesProvider = FutureProvider.autoDispose<List<String>>((ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final dateFormat = ref.read(dateFormatProvider);
  final input = ref.read(turnoProvider);
  return firestore.collection("turnos")
  .withConverter(fromFirestore: (snapshot,_) => Turno.fromMap(snapshot.data()!, snapshot.id), toFirestore: (turno, _) => turno.toMap())
  .where("medico_id", isEqualTo: input.medicoSeleccionado!.id)
  .where("estado", isEqualTo: EstadoTurno.libre.toString())
  .orderBy("fecha_hora", descending: false)
  .get().then((value) => value.docs.map((e) => dateFormat.format(e.data().fechaHora)).toSet().toList());
});

final getTurnosDisponiblesDia = FutureProvider.autoDispose.family<List<Turno>, DateTime>((ref, fecha) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final input = ref.read(turnoProvider);
  return firestore.collection("turnos")
  .withConverter(fromFirestore: (snapshot,_) => Turno.fromMap(snapshot.data()!, snapshot.id), toFirestore: (turno, _) => turno.toMap())
  .where("fecha_hora", isGreaterThanOrEqualTo: fecha)
  .where("fecha_hora", isLessThan: fecha.add(Duration(days: 1)))
  .where("medico_id", isEqualTo: input.medicoSeleccionado!.id)
  .where("estado", isEqualTo: EstadoTurno.libre.toString())
  .get().then((value) => value.docs.map((e) => e.data()).toList());
});

final turnosPacienteQueryProvider = Provider.autoDispose.family<Query<Turno>, Set<EstadoTurno>>((ref, filtros) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final user = ref.read(userProvider);
  var turnosQuery =  firestore.collection("turnos").withConverter<Turno>(fromFirestore: (snapshot, _) => Turno.fromMap(snapshot.data()!, snapshot.id), toFirestore: (turno, _) => turno.toMap())
  .where("paciente_id", isEqualTo: user!.id);
  
  if (filtros.isNotEmpty) {
    turnosQuery = turnosQuery.where("estado", whereIn: filtros.map((e) => e.toString()));
  }

  turnosQuery = turnosQuery.orderBy("fecha_hora", descending: false);

  return turnosQuery;
} );