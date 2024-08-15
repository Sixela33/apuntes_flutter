import 'package:autoguard/presentation/entities/DataEntities/Turno.dart';
import 'package:autoguard/presentation/entities/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TurnoInfoScreen extends StatelessWidget {
  final Turno turno;

  const TurnoInfoScreen({Key? key, required this.turno}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Información del Turno"),
        backgroundColor: Color(0xFF8BC34A),
        elevation: 0,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xFFF5F5F5),
        padding: EdgeInsets.all(20.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Médico: ${turno.medicoName}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Especialidad: ${turno.especialidadSeleccionada}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Fecha y Hora: ${turno.fechaHora.toString()}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Razón de la Consulta: ${turno.razonConsulta}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Estado: ${turno.estado.toString().split('.').last}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
