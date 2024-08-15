import 'package:autoguard/presentation/entities/Firebase.dart';
import 'package:autoguard/presentation/entities/Usuario.dart';
import 'package:autoguard/presentation/providers/registrationProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository(this._firestore);

  Future<Usuario> getUsuario(String id) async {
    final snapshot = await _firestore.collection('users').doc(id).get();
    return Usuario.fromMap(snapshot.data()!);
  }

  Future<void> saveUsuario(RegistrationDto dto, String id) async {
    await _firestore.collection('users').doc(id).set(dto.toMap(id));
  }
}

final userRepositoryProvider = Provider((ref) => UserRepository(ref.read(firebaseFirestoreProvider)));