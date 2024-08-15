import 'package:autoguard/presentation/entities/DataEntities/ObraSocial.dart';
import 'package:autoguard/presentation/entities/Firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ObraSocialRepository {

  final FirebaseFirestore _firestore;
  ObraSocialRepository(this._firestore);

  Future<List<ObraSocial>> getObrasSociales() async {
    final obrasSociales = await _firestore.collection('obraSocial').get();
    return obrasSociales.docs.map((e) => ObraSocial.fromMap(e.data())).toList();
  }
}

final obraSocialRepositoryProvider = Provider<ObraSocialRepository>((ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  return ObraSocialRepository(firestore);
});

final getAllObrasSocialesProvider = FutureProvider.autoDispose<List<ObraSocial>>((ref) async {
  final obraSocialRepository = ref.read(obraSocialRepositoryProvider);
  return obraSocialRepository.getObrasSociales();
});