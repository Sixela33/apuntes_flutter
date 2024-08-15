import 'package:autoguard/presentation/entities/DataEntities/EspecialidadMedica.dart';
import 'package:autoguard/presentation/entities/Firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EspecialidadRepository {

  final FirebaseFirestore _firestore;
  EspecialidadRepository(this._firestore);

  Future<List<EspecialidadMedica>> getEspecialidades() async {
    final especialidades = await _firestore.collection('especialidad').get();
    return especialidades.docs.map((e) => EspecialidadMedica.fromMap(e.data())).toList();
  }
}

final especialidadRepositoryProvider = Provider<EspecialidadRepository>((ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  return EspecialidadRepository(firestore);
});

final getAllEspecialidadesProvider = FutureProvider.autoDispose<List<EspecialidadMedica>>((ref) async {
  final especialidadRepository = ref.read(especialidadRepositoryProvider);
  return especialidadRepository.getEspecialidades();
});