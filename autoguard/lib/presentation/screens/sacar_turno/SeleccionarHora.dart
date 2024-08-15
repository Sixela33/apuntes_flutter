import 'package:autoguard/presentation/screens/sacar_turno/TimeSlot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:autoguard/presentation/providers/turnoProvider.dart';
import 'package:autoguard/presentation/entities/DataEntities/Turno.dart';
import 'package:autoguard/presentation/providers/dbProvider.dart';
import 'package:go_router/go_router.dart';
import 'package:autoguard/presentation/entities/ThemeProvider.dart';

final turnosDelDiaProvider = FutureProvider<List<Turno>>((ref) {
  final turnoNotifier = ref.watch(turnoProvider.notifier);
  return ref.read(databaseNotifierProvider).getTurnosPorMedicoYFecha(
    turnoNotifier.state.medicoSeleccionado.id,
    turnoNotifier.state.fechaSeleccionada
  );
});

class SeleccionarHora extends ConsumerStatefulWidget {
  const SeleccionarHora({Key? key}) : super(key: key);

  @override
  _SeleccionarHoraState createState() => _SeleccionarHoraState();
}

class _SeleccionarHoraState extends ConsumerState<SeleccionarHora> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(turnosDelDiaProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final turnoNotifier = ref.watch(turnoProvider.notifier);
    final databaseNotifier = ref.watch(databaseNotifierProvider);
    final themeProvider = ref.watch(themeNotifier);
    final medicoSeleccionado = turnoNotifier.state.medicoSeleccionado;
    final List<TimeOfDay> availableSlots = [];

    TimeOfDay currentTimeSlot = medicoSeleccionado.horaApertura;

    // mientras currrentTimeSlot no sea mayor que la hora de cierre
    while (currentTimeSlot.hour < medicoSeleccionado.horaCierre.hour || 
           (currentTimeSlot.hour == medicoSeleccionado.horaCierre.hour && currentTimeSlot.minute < medicoSeleccionado.horaCierre.minute)) {
      
      // se agrega un turno cada duración turno
      availableSlots.add(currentTimeSlot);
      final int totalMinutes = currentTimeSlot.hour * 60 + currentTimeSlot.minute + medicoSeleccionado.duracionTurno;
      currentTimeSlot = TimeOfDay(hour: totalMinutes ~/ 60, minute: totalMinutes % 60);
    }

    final turnosDelDia = ref.watch(turnosDelDiaProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Hora'),
        backgroundColor: themeProvider.primaryColor,
        elevation: 0,
      ),
      body: turnosDelDia.when(
        data: (turnos) {
          final List<TimeOfDay> horariosReservados = turnos.map((turno) {
            final DateTime fechaHora = turno.fechaHora;
            return TimeOfDay(hour: fechaHora.hour, minute: fechaHora.minute);
          }).toList();

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: availableSlots.length,
                  itemBuilder: (context, index) {
                    final TimeOfDay timeSlot = availableSlots[index];
                    final bool isSelected = _selectedTime.hour == timeSlot.hour && _selectedTime.minute == timeSlot.minute;
                    final bool isReserved = horariosReservados.any((time) => time.hour == timeSlot.hour && time.minute == timeSlot.minute);
                    final String timeLabel = '${timeSlot.hour.toString().padLeft(2, '0')}:${timeSlot.minute.toString().padLeft(2, '0')}';

                    return TimeSlot(
                      timeLabel: timeLabel,
                      isSelected: isSelected,
                      isReserved: isReserved,
                      onTap: isReserved ? null : () {
                        setState(() {
                          _selectedTime = timeSlot;
                        });
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FilledButton(
                  onPressed: () async {
                    turnoNotifier.setTime(_selectedTime);
                    //await databaseNotifier.agendarTurnoMedico(turnoNotifier.state);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Turno reservado con éxito')),
                    );
                    context.push('/home');
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: themeProvider.primaryColor,
                  foregroundColor: themeProvider.scaffoldBackgroundColor,
                ),
                  child: const Text('Enviar'),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
