import 'dart:math';

import 'package:autoguard/presentation/providers/registrationProvider.dart';
import 'package:autoguard/presentation/providers/utilProviders.dart';
import 'package:autoguard/presentation/screens/RegistrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Registerscreen extends StatelessWidget {

  PageController _pageController = PageController();
  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: const Color(0xFF8BC34A), // Verde claro
        elevation: 0,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          _PersonalData(nextPage),
          const RegistrationScreen(),
        ],
      ),
    );
  }
}

class _PersonalData extends ConsumerStatefulWidget {
  final Function nextPage;
  _PersonalData(this.nextPage);

  @override
  _PersonalDataState createState() => _PersonalDataState();
}

class _PersonalDataState extends ConsumerState<_PersonalData> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerSurname = TextEditingController();
  TextEditingController controllerDNI = TextEditingController();
  TextEditingController controllerBirthDate = TextEditingController();

  DateTime? fecha_nacimiento;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final dateFormat = ref.read(dateFormatProvider);
    return Form(
      key: formKey,
      child: 
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          
          child: Column(
            children: [
              TextFormField(
          controller: controllerName,
          decoration: const InputDecoration(
            labelText: 'Nombre',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) => validarCampoAlfa(value, 'nombre'),
              ),
              const SizedBox(height: 20),
              TextFormField(
          controller: controllerSurname,
          decoration: const InputDecoration(
            labelText: 'Apellido',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) => validarCampoAlfa(value, 'apellido'),
              ),
              const SizedBox(height: 20),
              TextFormField(
          controller: controllerDNI,
          decoration: const InputDecoration(
            labelText: 'DNI',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            prefixIcon: Icon(Icons.credit_card),
          ),
          validator: (value) => validarCampoNumerico(value, 'DNI'),
              ),
              const SizedBox(height: 20),
              TextFormField(
          controller: controllerBirthDate,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Fecha de nacimiento',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            prefixIcon: Icon(Icons.calendar_today),
          ),
          validator: (value) => value == null || value.isEmpty ? 'Por favor ingrese su fecha de nacimiento' : null,
          onTap: () async {
            await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1914),
              lastDate: DateTime.now(),
            ).then((value) {
              if (value != null) {
                controllerBirthDate.text = dateFormat.format(value);
                fecha_nacimiento = value;
              }
            });
          },
              ),
              const SizedBox(height: 20),
              IconButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              ref.read(registrationProvider.notifier).setDatosPersonales(controllerName.text, controllerSurname.text, controllerDNI.text, fecha_nacimiento!);
              widget.nextPage();
            }
          },
          icon: const Icon(Icons.arrow_forward),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFF8BC34A)), // Verde claro
            shape: MaterialStateProperty.all(const CircleBorder()),
          )
              ),
            ],
          ),
        ),
      ),
    );
  }
}



String? validarCampoAlfa(String? value, String nombreCampo) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingrese su $nombreCampo';
  } else if (value.length < 3) {
    return 'El $nombreCampo debe tener al menos 3 caracteres';
  } else if (value.length > 50) {
    return 'El $nombreCampo debe tener menos de 50 caracteres';
  } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
    return 'El $nombreCampo solo puede contener letras';
  }
  return null;
}

String? validarCampoNumerico(String? value, String nombreCampo) {
  if (value == null || value.isEmpty) {
    return null;
  } else if (value.length < 7) {
    return 'El $nombreCampo debe tener al menos 7 caracteres';
  } else if (value.length > 8) {
    return 'El $nombreCampo debe tener menos de 8 caracteres';
  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'El $nombreCampo solo puede contener números';
  }
  return null;
}