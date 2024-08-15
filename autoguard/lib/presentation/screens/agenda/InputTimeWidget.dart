import 'package:autoguard/presentation/providers/agendaProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InputTimeWidget extends ConsumerWidget {
  
  

  @override
  Widget build(BuildContext context, ref) {

    int? _fromTime = ref.watch(agendaProvider).fromTime;
  int? _toTime = ref.watch(agendaProvider).toTime;
  int? _interval = ref.watch(agendaProvider).interval;


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: DropdownButton(
            hint: Text('Selecciona el intervalo entre turnos'),
            value: _interval,
            items: List.of([
              DropdownMenuItem(
                child: Text('15 minutos'),
                value: 15,
              ),
              DropdownMenuItem(
                child: Text('30 minutos'),
                value: 30,
              ),
              DropdownMenuItem(
                child: Text('1 hora'),
                value: 60,
              ),
            ]),
            onChanged: (value) {
              ref.read(agendaProvider.notifier).setInterval(value as int);
            },
          ),
        ),
        Container(
          child: DropdownButton(
            items: _interval == null ? [] : List.generate(getLengthFrom(_interval!), (index) {
              return DropdownMenuItem(
                child: Text(getHourFrom(index, _interval!)),
                value: index * (_interval!),
              );
            }),
            onChanged: (value) {
              ref.read(agendaProvider.notifier).setFromTime(value as int);
            },
            value: _fromTime,
            hint: Text('Selecciona la hora de inicio'),
          ),
        ),
        Container(
          child: DropdownButton(
            items: _interval == null || _fromTime == null ? [] : List.generate(getLengthTo(_fromTime! ,_interval!), (index) {
              return DropdownMenuItem(
                child: Text(getHourTo(_fromTime!, _interval!, index)),
                value: _fromTime + index * (_interval!),
              );
            }),
            onChanged: (value) {
              ref.read(agendaProvider.notifier).setToTime(value as int);
            },
            value: _toTime,
            hint: Text('Selecciona la hora de fin'),
          ),
        ),
        ElevatedButton(
          child: Text('Guardar'),
          onPressed: () {
            ref.read(agendaProvider.notifier).save();
            ref.read(agendaProvider.notifier).reset();
            context.go("/home");
          },
        )
      ],
    );
  }
}

int getLengthFrom(int interval) {
  return (60 / interval * 24).truncate();
}

int getLengthTo(int from, int interval) {
  return ((24 * 60 - from) / interval).truncate();
}

String getHourFrom(int index, int interval) {
  int hour = interval * index ~/ 60;
  int minute = interval * index % 60;



  return hour.toString().padLeft(2, '0') + ':' + minute.toString().padRight(2, '0');
}

String getHourTo(int value, int interval, int index) {
  int hour = (value + interval * (index + 1)) ~/ 60;
  int minute = (value + interval * (index + 1)) % 60;

  return hour.toString().padLeft(2, '0') + ':' + minute.toString().padRight(2, '0');
}