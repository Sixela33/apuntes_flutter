import 'package:autoguard/presentation/entities/ThemeProvider.dart';
import 'package:autoguard/presentation/providers/dbProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:autoguard/presentation/screens/RegistrarMedico.dart';
import 'package:go_router/go_router.dart';

class AdminScreen extends StatelessWidget {
  static String name = 'Agregar obra social';
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AdminScreen();
  }
}

class _AdminScreen extends ConsumerWidget {
  _AdminScreen();

  final TextEditingController nombreNuevaObraSocial = TextEditingController();
  final TextEditingController nombreNuevaEspecialidad = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final databaseNotifier = ref.watch(databaseNotifierProvider);
    final theme = ref.watch(themeNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cargar obra social y especialidad"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Insertar nombre de la obra social: "),
            TextField(
              controller: nombreNuevaObraSocial,
              decoration: const InputDecoration(
                hintText: 'Nombre',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            FilledButton(
              onPressed: () async {
                try {
                  await databaseNotifier.addObraSocial(nombreNuevaObraSocial.text);
                  nombreNuevaObraSocial.clear;
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Obra social agregada con exito')),
                    );
                } catch (e){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al agregar obra social: $e')),
                  );
                }
              },
              child: const Text("Guardar Obra Social"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(theme.primaryColor),
              )
            ),
            const SizedBox(height: 10),
            const Text("Insertar nombre de la especialidad: "),
            TextField(
              controller: nombreNuevaEspecialidad,
              decoration: const InputDecoration(
                hintText: 'Nombre',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            FilledButton(
                onPressed: () async {
                  try {
                    databaseNotifier.addEspecialidad(nombreNuevaEspecialidad.text);
                    nombreNuevaEspecialidad.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Especialidad agregada con exito')),
                    );
                  } catch (e) {
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error en el registro: $e')),
                    );
                  }
                  
                },
                child: const Text("Guardar Especialidad"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(theme.primaryColor),
                )
            ),
            const SizedBox(height: 10),
            FilledButton(
              
              onPressed: () {
                context.push('/registroMedico');
              }, 
              child: Text('Añadir Medico'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(theme.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
