import 'package:autoguard/presentation/entities/ThemeProvider.dart';
import 'package:autoguard/presentation/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:autoguard/presentation/providers/dbProvider.dart';
import 'package:autoguard/presentation/providers/turnoProvider.dart';
import 'package:autoguard/presentation/entities/DataEntities/Medic.dart';
import 'package:go_router/go_router.dart';

final medicosDisponiblesProvider = FutureProvider<List<Medic>>((ref) {
  final turnoState = ref.watch(turnoProvider);
  final user = ref.watch(userProvider);
  return ref.read(databaseNotifierProvider).getMedicosOfEspecialidad(turnoState.especialidadSeleccionada, user!.obrasSociales![0]);
});

class SeleccionarMedico extends StatelessWidget {
  const SeleccionarMedico({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SeleccionarMedico();
  }
}

class _SeleccionarMedico extends ConsumerStatefulWidget {
  const _SeleccionarMedico({
    super.key,
  });

  @override
  _SeleccionarMedicoState createState() => _SeleccionarMedicoState();
}

class _SeleccionarMedicoState extends ConsumerState<_SeleccionarMedico> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(medicosDisponiblesProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final turnoNotifier = ref.watch(turnoProvider.notifier);
    final medicosDisponibles = ref.watch(medicosDisponiblesProvider);
    final themeProvider = ref.watch(themeNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Médico'),
        backgroundColor: themeProvider.primaryColor,
        elevation: 0,
      ),
      body: medicosDisponibles.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (medicos) {
          return medicos.isEmpty
              ? 
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sentiment_dissatisfied,
                      size: 48,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No se encontraron médicos disponibles.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
              : 
           ListView.builder(
            itemCount: medicos.length,
            itemBuilder: (context, index) {
              final medico = medicos[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: 
                        ListTile(
                          title: Text(medico.nombre),
                          subtitle: Text(medico.especialidades.join(', ')),
                          leading: Icon(Icons.person, color: themeProvider.primaryColorLight),
                          onTap: () {
                            turnoNotifier.setMedicoSeleccionado(medico);
                            context.pushReplacement('/sacarTurno/seleccionarFecha');
                          },
                        ),
                    ),
                    medico.rating != null
                        ? RatingBarIndicator(itemBuilder: (context,_) => const Icon(Icons.star, color: Colors.amber), 
                        rating: medico.rating!.puntaje / medico.rating!.cantidad,
                        itemSize: 20.0,
                        )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
