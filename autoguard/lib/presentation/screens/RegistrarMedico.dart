import 'package:autoguard/core/repository/EspecialidadRepository.dart';
import 'package:autoguard/core/repository/ObraSocialRepository.dart';
import 'package:autoguard/presentation/entities/DataEntities/EspecialidadMedica.dart';
import 'package:autoguard/presentation/entities/DataEntities/ObraSocial.dart';
import 'package:autoguard/presentation/providers/dbProvider.dart';
import 'package:autoguard/presentation/screens/RegistrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistroMedicoScreen extends StatelessWidget {
  static String name = "Registrar médico";

  @override
  Widget build(BuildContext context) {
    return const _RegistroMedicoScreen();
  }
}

class _RegistroMedicoScreen extends ConsumerStatefulWidget {
  const _RegistroMedicoScreen({Key? key}) : super(key: key);

  @override
  _RegistroMedicoScreenState createState() => _RegistroMedicoScreenState();
}

class _RegistroMedicoScreenState extends ConsumerState<_RegistroMedicoScreen> {
  final TextEditingController controllerNombre = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerEspecialidad = TextEditingController();
  final List<ObraSocial> obrasSocialesSeleccionadas = [];
  final List<EspecialidadMedica> especialidadesMedicasSeleccionadas = [];

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controllerNombre.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
    controllerEspecialidad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final databaseProvider = ref.watch(databaseNotifierProvider);
    final especialidadesMedicas = ref.watch(getAllEspecialidadesProvider);
    final obrasSociales = ref.watch(getAllObrasSocialesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Médico'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Registrar Médico',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controllerNombre,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => validarCampoNombre(value),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controllerEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => validarCampoEmail(value),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controllerPassword,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) => validarCampoPassword(value),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<EspecialidadMedica>(
                  hint: const Text('Seleccionar especialidades'),
                  value: null,
                  onChanged: (selectedEspecialidad) {
                    if (selectedEspecialidad != null) {
                      setState(() {
                        if (especialidadesMedicasSeleccionadas.contains(selectedEspecialidad)) {
                          especialidadesMedicasSeleccionadas.remove(selectedEspecialidad);
                        } else {
                          especialidadesMedicasSeleccionadas.add(selectedEspecialidad);
                        }
                      });
                    }
                  },
                  validator: (value) => especialidadesMedicasSeleccionadas.isNotEmpty ? null : 'Por favor, selecciona al menos una especialidad',
                  items: especialidadesMedicas.when(data: (data) => data.map((especialidad) {
                    return DropdownMenuItem<EspecialidadMedica>(
                      value: especialidad,
                      child: Text(especialidad.nombre),
                    );
                  }).toList(),
                  error: (error, _) => null,
                  loading: () => null)
                ),
                const SizedBox(height: 20),
                Wrap(
                  children: especialidadesMedicasSeleccionadas.map((especialidad) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          especialidadesMedicasSeleccionadas.remove(especialidad);
                        });
                      },
                      child: Chip(
                        label: Text(especialidad.nombre),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                const Text("Seleccioná tus obras sociales:"),
                DropdownButtonFormField<ObraSocial>(
                  hint: const Text('Seleccionar obra social'),
                  value: null, 
                  onChanged: (selectedObraSocial) {
                    if (selectedObraSocial != null) {
                      setState(() {
                        if (obrasSocialesSeleccionadas.contains(selectedObraSocial)) {
                          obrasSocialesSeleccionadas.remove(selectedObraSocial);
                        } else {
                          obrasSocialesSeleccionadas.add(selectedObraSocial);
                        }
                      });
                    }
                  },
                  validator: (value) => obrasSocialesSeleccionadas.isNotEmpty ? null : 'Por favor, selecciona al menos una obra social',
                  items: obrasSociales.when(data: (data) => data.map((obraSocial) {
                    return DropdownMenuItem<ObraSocial>(
                      value: obraSocial,
                      child: Text(obraSocial.nombre),
                    );
                  }).toList(),
                  error: (error, _) => null,
                  loading:  () => null)
                ),
                const SizedBox(height: 20),
                Wrap(
                  children: obrasSocialesSeleccionadas.map((obraSocial) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          obrasSocialesSeleccionadas.remove(obraSocial);
                        });
                      },
                      child: Chip(
                        label: Text(obraSocial.nombre),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await databaseProvider.registerWithEmailAndPasswordDoctor(
                          controllerEmail.text,
                          controllerPassword.text,
                          controllerNombre.text,
                          obrasSocialesSeleccionadas,
                          especialidadesMedicasSeleccionadas
                        );
                       
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('¡Registro de médico exitoso!')),
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error en el registro: $e')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Registrar Médico'),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}

validarCampoNombre(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, ingrese un nombre';
  }
  return null;
}
