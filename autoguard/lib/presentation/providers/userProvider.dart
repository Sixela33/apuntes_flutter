import 'package:autoguard/presentation/entities/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, Usuario?>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<Usuario?> {
  UserNotifier() : super(null);

  Future<void> login() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    await FirebaseFirestore.instance.collection('users').doc(user.uid).get().then((value) {
      state = Usuario.fromMap(value.data()!);
    });
  }

  void logout() {
    state = null;
  }
}