class Rating {
  final int cantidad;
  final double puntaje;

  Rating({
    required this.cantidad,
    required this.puntaje,
  });

  factory Rating.fromMap(data) {
    return Rating(
      cantidad: data['cantidad'] as int,
      puntaje: data['puntaje'] as double,
    );
  }
}