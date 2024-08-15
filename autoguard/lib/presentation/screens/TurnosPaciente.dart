import 'package:autoguard/core/repository/TurnoRepository.dart';
import 'package:autoguard/presentation/entities/DataEntities/EstadoTurno.dart';
import 'package:autoguard/presentation/entities/DataEntities/Turno.dart';
import 'package:autoguard/presentation/providers/userProvider.dart';
import 'package:autoguard/presentation/providers/utilProviders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TurnosPaciente extends ConsumerStatefulWidget {
  @override
  _TurnosMedicoState createState() => _TurnosMedicoState();
}

class _TurnosMedicoState extends ConsumerState<TurnosPaciente> {
  
  Set<EstadoTurno> filters = {EstadoTurno.pendiente};
  var showFilters = false;

  @override
  Widget build(BuildContext context) {
    final dateFormat = ref.read(dateTimeFormatProvider);
  var turnosQuery = ref.watch(turnosPacienteQueryProvider(filters));
  

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Turnos',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              setState(() {
                showFilters = !showFilters;
              });
            },
          )
        ],
        backgroundColor: const Color(0xFF8BC34A),
        elevation: 0,
      ),
      body: Column(
        children: [
            showFilters ? Wrap(
            spacing: 5.0,
            children: EstadoTurno.values.map((EstadoTurno estado) {
              return FilterChip(
                label: Text(estado.name),
                selected: filters.contains(estado),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      filters.add(estado);
                    } else {
                      filters.remove(estado);
                    }
                    ref.refresh(turnosPacienteQueryProvider(filters));
                  });
                },
              );
            }).toList(),
            ) : Container(),
          Expanded(
            child: FirestoreListView<Turno>(
              shrinkWrap: true,
              query: turnosQuery,
              itemBuilder: (context, doc) {
                final turno = doc.data();
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text('${turno.medicoName}${turno.especialidadSeleccionada != null ?  "-${turno.especialidadSeleccionada!}" : ''}'),
                    subtitle: Text('Fecha: ${dateFormat.format(turno.fechaHora)}'),
                    trailing: Text(doc["estado"].toString().split('.').last),
                    onTap: () {
                      context.push("/detalleTurnoPaciente", extra: turno.id);
                    },
                  ),
                );
              },
              emptyBuilder: (context) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today, size: 100, color: Colors.grey[400]),
                      const SizedBox(height: 20),
                      const Text(
                        'No se encontraron turnos',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
