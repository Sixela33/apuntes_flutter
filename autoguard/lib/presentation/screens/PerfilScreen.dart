import 'package:autoguard/presentation/providers/userProvider.dart';
import 'package:autoguard/presentation/providers/utilProviders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PerfilScreen extends ConsumerWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final usuario = ref.watch(userProvider);
    final dateFormat = ref.read(dateFormatProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: const Color(0xFF8BC34A),
        elevation: 0,
      ),
      body: Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/profile_picture.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextField(
                    controller: TextEditingController(text: usuario?.email ?? ""),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    readOnly: true,
                        ),
                        const SizedBox(height: 10),
                        TextField(
                    controller: TextEditingController(text: usuario?.nombre ?? ""),
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: TextEditingController(text: usuario?.apellido ?? ""),
                    decoration: const InputDecoration(
                      labelText: 'Apellido',
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 10),
                   TextField(
                    controller: TextEditingController(text: usuario?.dni ?? ""),
                    decoration: const InputDecoration(
                      labelText: 'DNI',
                    ),
                    readOnly: true,
                   ),
                   const SizedBox(height: 10),
                   TextField(
                    controller: TextEditingController(text: dateFormat.format(usuario?.fecha_nacimiento ?? DateTime.now())),
                    decoration: const InputDecoration(
                      labelText: 'Fecha de nacimiento',
                    ),
                    readOnly: true,
                   ),
                      ],
                    ),
                  )
                  
                ],
              ),
            ),
      );
  }
}
