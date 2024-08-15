import 'package:autoguard/presentation/entities/ThemeProvider.dart';
import 'package:autoguard/presentation/providers/turnoProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

class SeleccionarFecha extends StatelessWidget {
  // https://pub.dev/packages/table_calendar

  const SeleccionarFecha({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SeleccionarFecha();
  }
}

class _SeleccionarFecha extends ConsumerStatefulWidget {
  const _SeleccionarFecha({
    super.key,
  });

  @override
  _SeleccionarFechaState createState() => _SeleccionarFechaState();
}

class _SeleccionarFechaState extends ConsumerState<_SeleccionarFecha> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final DateTime _firstDay = DateTime.now();
  final DateTime _lastDay = DateTime.utc(2030, 1, 1);

  @override
  Widget build(BuildContext context) {
    final turnoNotifier = ref.watch(turnoProvider.notifier);
    final themeProvider = ref.watch(themeNotifier);
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Seleccionar Fecha'),
        ),
        body: Center(
          child: Column(
            children: [
            TableCalendar(
              availableCalendarFormats: {CalendarFormat.month: 'Month'},
              focusedDay: _focusedDay,
              firstDay: _firstDay,
              lastDay: _lastDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (selectedDay.weekday == DateTime.saturday || selectedDay.weekday == DateTime.sunday) {
                  return;
                }
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: themeProvider.primaryColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: themeProvider.primaryColor,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: const TextStyle(color: Colors.red),
              ),
            ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  turnoNotifier.setFechaSeleccionada(_selectedDay);
                  context.push('/sacarTurno/seleccionarHora'); 
                  
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: themeProvider.primaryColor,
                foregroundColor: themeProvider.scaffoldBackgroundColor,
              ),
                child: const Text('Seleccionar Fecha'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}