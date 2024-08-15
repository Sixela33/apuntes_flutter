import 'package:autoguard/presentation/components/functions/consultarEspecialista.dart';
import 'package:autoguard/presentation/entities/DataEntities/EspecialidadMedica.dart';
import 'package:autoguard/presentation/entities/ThemeProvider.dart';
import 'package:autoguard/presentation/providers/dbProvider.dart';
import 'package:autoguard/presentation/providers/turnoProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ConsultarEspecialista extends StatelessWidget {
  const ConsultarEspecialista({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ConsultarEspecialista();
  }
}

class _ConsultarEspecialista extends ConsumerWidget {
  _ConsultarEspecialista({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  void continueFunction(dbNotif, turnoNotif) async {
    final inputUsuario = _controller.text;
    await consultarEspecialista(inputUsuario, dbNotif.especialidadesMedicas, turnoNotif);
    turnoNotif.nextStep();
  }

  @override
  Widget build(BuildContext context, ref) {
    final databaseNotifier = ref.watch(databaseNotifierProvider);
    final turnoNotifierController = ref.read(turnoProvider.notifier);
     final themeProvider = ref.watch(themeNotifier);
    databaseNotifier.getEspecialidades();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta Especialista'),
        backgroundColor: const Color(0xFF8BC34A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¿Cuál es la razón de su consulta?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              maxLines: 8,
              decoration: const InputDecoration(
                hintText: 'Escribe aquí tu consulta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text("Cancelar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeProvider.primaryColor,
                    foregroundColor: themeProvider.scaffoldBackgroundColor,
                  )
                ),
                ElevatedButton(
                  onPressed: () async {
                    final inputUsuario = _controller.text;
                    await consultarEspecialista(inputUsuario, databaseNotifier.especialidadesMedicas, turnoNotifierController);
                    context.pushReplacement('/sacarTurno/seleccionarEspecialista');
                  },
                  child: const Text('Continuar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeProvider.primaryColor,
                    foregroundColor: themeProvider.scaffoldBackgroundColor,
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
