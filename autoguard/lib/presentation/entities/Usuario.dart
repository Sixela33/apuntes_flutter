import 'package:autoguard/presentation/entities/DataEntities/EspecialidadMedica.dart';
import 'package:autoguard/presentation/entities/DataEntities/ObraSocial.dart';
import 'package:autoguard/presentation/entities/Rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String? email;
  final String? nombre;
  final String? apellido;
  final String? dni;
  final List<EspecialidadMedica>? especialidades;
  final String id;
  final bool? esMedico;
  final List<String>? obrasSociales;
  final Rating? rating;
  final DateTime? fecha_nacimiento;

  Usuario(
      {this.email,
      this.especialidades,
      this.nombre,
      required this.id,
      this.esMedico,
      this.obrasSociales,
      this.fecha_nacimiento,
      this.rating,
      this.apellido,
      this.dni});

  Usuario copyWith({
    String? email,
    List<EspecialidadMedica>? especialidades,
    String? nombre,
    String? id,
    bool? esMedico,
    List<String>? obrasSociales,
  }) {
    return Usuario(
      email: email ?? this.email,
      especialidades: especialidades ?? this.especialidades,
      nombre: nombre ?? this.nombre,
      id: id ?? this.id,
      esMedico: esMedico ?? this.esMedico,
      obrasSociales: obrasSociales ?? this.obrasSociales,
    );
  }

  factory Usuario.fromMap(Map<String, dynamic> data) => Usuario(
        email: data['email'] as String,
        especialidades: (data['especialidades'] as List<dynamic>?)
            ?.cast<EspecialidadMedica>(),
        nombre: data['nombre'] as String?,
        id: data['id'] as String,
        esMedico: data['es_medico'] as bool,
        obrasSociales:
            (data['obras_sociales'] as List<dynamic>?)?.cast<String>(),
        fecha_nacimiento: data['fecha_nacimiento'] == null ? null : (data['fecha_nacimiento'] as Timestamp).toDate(),
        apellido: data['apellido'] as String?,
        dni: data['dni'] as String?,
        rating: data['rating'] == null ? null : Rating.fromMap(data['rating']),
      );
}
