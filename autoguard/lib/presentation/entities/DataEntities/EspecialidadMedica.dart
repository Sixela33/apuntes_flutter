class EspecialidadMedica {
  final String id;
  final String nombre;

  EspecialidadMedica({required this.id, required this.nombre});

  factory EspecialidadMedica.fromMap(Map<String, dynamic> data) => EspecialidadMedica(
    id: data['id'] as String,
    nombre: data['nombre'] as String,
  );
}