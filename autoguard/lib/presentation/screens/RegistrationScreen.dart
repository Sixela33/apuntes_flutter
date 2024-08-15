import 'package:autoguard/presentation/entities/DataEntities/Turno.dart';
import 'package:autoguard/presentation/providers/registrationProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:autoguard/presentation/entities/DataEntities/ObraSocial.dart';
import 'package:autoguard/presentation/providers/dbProvider.dart';
import 'package:autoguard/presentation/screens/LoginScreen.dart';

final obraSocialProvider = FutureProvider.autoDispose<List<ObraSocial>>((ref) {
  return ref.read(databaseNotifierProvider).getObrasSociales();
});

class RegistrationScreen extends ConsumerStatefulWidget {
  static String name = "Registrar usuario";

  const RegistrationScreen({Key? key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final List<ObraSocial> obrasSocialesSeleccionadas = [];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final databaseNotifier = ref.watch(databaseNotifierProvider);
    final obrasSocialesProvider = ref.watch(obraSocialProvider);

    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controllerEmail,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) => validarCampoEmail(value),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: controllerPassword,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) => validarCampoPassword(value)
              ),
              const SizedBox(height: 20),
              const Text("Seleccioná tus obras sociales:"),
              obrasSocialesProvider.when(
                data: (data) => DropdownButtonFormField<ObraSocial>(
                hint: const Text('Seleccionar obra social'),
                value: null,
                validator: (value) => obrasSocialesSeleccionadas.isEmpty ? 'Por favor, selecciona al menos una obra social' : null,
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
                items: data.map((obraSocial) {
                    return DropdownMenuItem<ObraSocial>(
                      value: obraSocial,
                      child: Text(obraSocial.nombre),
                    );
                  }).toList(),     
              ),
                error: (error, _) => const Text('Error: ocurrio un error al cargar las obras sociales'),
                loading: () => const CircularProgressIndicator(),
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
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  try {
                     ref.read(registrationProvider.notifier).setDatosCuenta(
                      controllerEmail.text,
                      controllerPassword.text,
                      obrasSocialesSeleccionadas,
                    );
                    await ref.read(registrationProvider.notifier).registrarse();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('¡Registro exitoso!')),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error en el registro: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF8BC34A), // Verde claro
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      );
  }
}
  
  String? validarCampoEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese un email';
    }
    if (!value.contains('@')) {
      return 'Por favor, ingrese un email válido';
    }
    return null;
  }
  
  String? validarCampoPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese una contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }
