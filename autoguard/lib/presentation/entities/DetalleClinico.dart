import 'package:cloud_firestore/cloud_firestore.dart';

class DetalleClinico {
  final DateTime fechaHora;
  final String diagnostico;

  DetalleClinico({
    required this.fechaHora,
    required this.diagnostico,
  });

  factory DetalleClinico.fromMap(Map<String, dynamic> map) {
    return DetalleClinico(
      fechaHora: (map['fecha_hora'] as Timestamp).toDate(),
      diagnostico: map['diagnostico'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fecha_hora': fechaHora,
      'diagnostico': diagnostico,
    };
  }
}