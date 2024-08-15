import 'package:autoguard/presentation/entities/Rating.dart';
import 'package:flutter/material.dart';

class Medic {
  final String id;
  final String nombre;
  final String email;
  final List<String> especialidades;
  final List<String> obras_sociales;
  final bool es_medico;
  final Rating? rating;
  int duracionTurno;
  TimeOfDay horaApertura;
  TimeOfDay horaCierre;

  Medic({
    required this.email,
    required this.especialidades,
    required this.obras_sociales,
    required this.es_medico,
    required this.id,
    required this.nombre,
    this.rating,
    this.horaApertura = const TimeOfDay(hour: 8, minute: 0),
    this.horaCierre = const TimeOfDay(hour: 18, minute: 0),
    this.duracionTurno = 30,
  });

  factory Medic.fromMap(Map<String, dynamic> data) {
    Medic temp_medic = Medic( 
      email: data['email'] as String,
      id: data['id'] as String,
      nombre: data['nombre'] as String,
      especialidades: List<String>.from(data['especialidades'] as List<dynamic>),
      obras_sociales: List<String>.from(data['obras_sociales'] as List<dynamic>),
      es_medico: data['es_medico'] ? data['es_medico']  as bool : false,
      rating: data['rating'] == null ? null : Rating.fromMap(data['rating']),
      );
    
    return temp_medic;
  }
}
