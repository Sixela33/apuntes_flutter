import 'package:autoguard/core/repository/TurnoRepository.dart';
import 'package:autoguard/presentation/entities/DataEntities/EstadoTurno.dart';
import 'package:autoguard/presentation/entities/DataEntities/Turno.dart';
import 'package:autoguard/presentation/providers/historiaClinicaProvider.dart';
import 'package:autoguard/presentation/providers/utilProviders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TurnoPaciente extends ConsumerWidget {
  final String turno;

  TurnoPaciente({required this.turno});

  @override
  Widget build(BuildContext context, ref) {
    final detalleTurno = ref.watch(detalleTurnoProvider(turno));

    return detalleTurno.when(
      data: (data) => DetalleTurnoPaciente(detalleTurno: data),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}

class DetalleTurnoPaciente extends ConsumerWidget {
  DetalleTurno detalleTurno;
  DetalleTurnoPaciente({required this.detalleTurno});

  @override
  Widget build(BuildContext context, ref) {
    final dateFormat = ref.read(dateTimeFormatProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Turnos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF8BC34A),
        elevation: 0,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Medico: ${detalleTurno.medicoName}'),
            subtitle:
                Text('Fecha: ${dateFormat.format(detalleTurno.fechaHora)}'),
          ),
          ListTile(
            title: Text('Razon de consulta: ${detalleTurno.razonConsulta}'),
          ),
          ListTile(
            title:
                Text('Especialidad: ${detalleTurno.especialidadSeleccionada}'),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(
          detalleTurno.estado, context, ref, detalleTurno.id),
    );
  }

  Widget? _buildFloatingActionButton(
      EstadoTurno estado, BuildContext context, WidgetRef ref, String turnoId) {
    switch (estado) {
      case EstadoTurno.pendiente:
        return FloatingActionButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('¿Desea cancelar el turno?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await ref
                          .read(turnoRepositoryProvider)
                          .cancelarTurno(detalleTurno);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Aceptar'),
                  ),
                ],
              ),
            );
          },
          child: const Icon(Icons.delete),
        );
      case EstadoTurno.finalizado:
        return FloatingActionButton(
          child: const Icon(Icons.star),
          onPressed: () async {
            var puntaje = 0.0;
            await showDialog(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setState) {

                return AlertDialog(
                  title: const Text('Calificar atención'),
                  content: RatingBar.builder(
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (newrating) {
                      setState(() {
                        puntaje = newrating;
                      });
                    },
                    allowHalfRating: true,

                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await ref
                            .read(turnoRepositoryProvider)
                            .calificarTurno(turnoId, puntaje);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Aceptar'),
                    ),
                  ],
                );
                } 
                
              ),
            );
          },
        );
      default:
        return null;
    }
  }
}
