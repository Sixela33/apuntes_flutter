import 'package:autoguard/core/repository/TurnoRepository.dart';
import 'package:autoguard/presentation/entities/DataEntities/Turno.dart';
import 'package:autoguard/presentation/entities/ThemeProvider.dart';
import 'package:autoguard/presentation/providers/dbProvider.dart';
import 'package:autoguard/presentation/providers/turnoProvider.dart';
import 'package:autoguard/presentation/providers/utilProviders.dart';
import 'package:autoguard/presentation/screens/sacar_turno/TimeSlot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SacarTurno extends ConsumerStatefulWidget {
  @override
  _SacarTurnoState createState() => _SacarTurnoState();
}

class _SacarTurnoState extends ConsumerState<SacarTurno> {
  TextEditingController _fechaController = TextEditingController();
  DateTime? fecha;
    TimeOfDay _selectedTime = TimeOfDay.now();
    Turno? _selectedTurno;

  @override
  Widget build(BuildContext context) {
    var diasDisponibles = ref.watch(getDiasDisponiblesProvider);
    final dateFormat = ref.read(dateFormatProvider);
    final turnoNotifier = ref.watch(turnoProvider.notifier);
    final databaseNotifier = ref.watch(databaseNotifierProvider);
    final themeProvider = ref.watch(themeNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sacar Turno',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF8BC34A),
        elevation: 0,
      ),
      body: Column(
        children: [
          diasDisponibles.when(
            data: (data) {
              var _fecha;
                return Container(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _fechaController,
                  decoration: InputDecoration(
                  labelText: 'Fecha',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                    _fecha = await showDatePicker(
                      context: context,
                      firstDate: dateFormat.parse(data.first),
                      lastDate: dateFormat.parse(data.last),
                      initialDate: dateFormat.parse(data.first),
                      selectableDayPredicate: (day) {
                      return data.contains(dateFormat.format(day));
                      },
                    );
                    setState(() {
                      fecha = _fecha;
                      if (fecha != null) {
                      _fechaController.text = dateFormat.format(fecha!);
                      }
                    });
                    },
                  ),
                  ),
                ),
                );
            },
            error: (error, stack) => Text('Error: $error'),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
          const SizedBox(height: 16),
          const Divider(),
          fecha != null
              ? ref.watch(getTurnosDisponiblesDia(fecha!)).when(
                  data: (data) {
                    return Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final TimeOfDay timeSlot =
                              TimeOfDay.fromDateTime(data[index].fechaHora);
                          final bool isSelected =
                              _selectedTime.hour == timeSlot.hour &&
                                  _selectedTime.minute == timeSlot.minute;
                          final String timeLabel =
                              '${timeSlot.hour.toString().padLeft(2, '0')}:${timeSlot.minute.toString().padLeft(2, '0')}';

                          return TimeSlot(
                            timeLabel: timeLabel,
                            isSelected: isSelected,
                            isReserved: false,
                            onTap:  () {
                                    setState(() {
                                      _selectedTime = timeSlot;
                                      _selectedTurno = data[index];
                                    });
                                  },
                          );
                        },
                      ),
                    );
                  },
                  error: (error, stack) => Text('Error: $error'),
                  loading: () => const Center(child: CircularProgressIndicator()),
                )
              : const SizedBox(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FilledButton(
                  onPressed: () async {
                    await databaseNotifier.agendarTurnoMedico(turnoNotifier.getState(), _selectedTurno!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Turno reservado con éxito')),
                    );
                    context.go('/home');
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: themeProvider.primaryColor,
                  foregroundColor: themeProvider.scaffoldBackgroundColor,
                ),
                  child: const Text('Enviar'),
                ),
              ),
        ],
      ),
    );
  }
}
  