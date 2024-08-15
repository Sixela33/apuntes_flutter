import 'package:autoguard/core/repository/UserRepository.dart';
import 'package:autoguard/presentation/entities/DataEntities/ObraSocial.dart';
import 'package:autoguard/presentation/entities/Firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registrationProvider = StateNotifierProvider<RegistrationNotifier, RegistrationDto>((ref) {
  final firebaseAuth = ref.read(firebaseAuthProvider);
  final UserRepository = ref.read(userRepositoryProvider);
  return RegistrationNotifier(firebaseAuth, UserRepository);
});

class RegistrationNotifier extends StateNotifier<RegistrationDto> {
  final FirebaseAuth firebaseAuth;
  final UserRepository userRepository;
  RegistrationNotifier(this.firebaseAuth, this.userRepository) : super(RegistrationDto());

  void setDatosPersonales(String name, String surname, String dni, DateTime birthDate) {
    state = state.copyWith(name: name, surname: surname, dni: dni, birthDate: birthDate);
  }

  void setDatosCuenta(String email, String password, List<ObraSocial> obrasSocialesSeleccionadas) {
    state = state.copyWith(email: email, password: password, obrasSocialesSeleccionadas: obrasSocialesSeleccionadas.map((e) => e.nombre).toList());
  }

  Future<void> registrarse() async {
    final user = await firebaseAuth.createUserWithEmailAndPassword(email: state.email!, password: state.password!);
    await userRepository.saveUsuario(state, user.user!.uid);  
}
}

class RegistrationDto {

  String? name;
  String? surname;
  String? dni;
  DateTime? birthDate;
  String? email;
  String? password;
  List<String>? obrasSocialesSeleccionadas;

  RegistrationDto({
    this.name,
    this.surname,
    this.dni,
    this.email,
    this.password,
    this.obrasSocialesSeleccionadas,
    this.birthDate,
  });

  RegistrationDto copyWith({
    String? name,
    String? surname,
    String? dni,
    String? email,
    String? password,
    List<String>? obrasSocialesSeleccionadas,
    DateTime? birthDate,
  }) {
    return RegistrationDto()
      ..name = name ?? this.name
      ..surname = surname ?? this.surname
      ..dni = dni ?? this.dni
      ..email = email ?? this.email
      ..password = password ?? this.password
      ..obrasSocialesSeleccionadas = obrasSocialesSeleccionadas ?? this.obrasSocialesSeleccionadas
      ..birthDate = birthDate ?? this.birthDate;
  }

  Map<String, dynamic> toMap(String id) {
    return {
      'name': name,
      'apellido': surname,
      'es_medico': false,
      'id': id,
      'dni': dni,
      'email': email,
      'obras_sociales': obrasSocialesSeleccionadas,
      'fecha_nacimiento': birthDate,
    };
  }

}

