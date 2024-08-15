import 'package:autoguard/core/repository/TurnoRepository.dart';
import 'package:autoguard/presentation/entities/DetalleClinico.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historiaClinicaProvider = FutureProvider.autoDispose.family<List<DetalleClinico>, String>((ref, id) async {
  final turnoRepository = ref.read(turnoRepositoryProvider);
  return turnoRepository.getHistoriaClinica(id);
});