import 'package:autoguard/presentation/components/BotonMenu.dart';
import 'package:autoguard/presentation/providers/dbProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MenuMedico extends ConsumerWidget {
  const MenuMedico({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final databaseNotifier = ref.watch(databaseNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu Médico',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF8BC34A),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const BotonMenu(
                texto: 'Tus Consultas',
                ruta: '/turnos',
                icono: Icons.medical_services,
              ),
              const BotonMenu(
                texto: 'Agenda',
                ruta: '/agenda',
                icono: Icons.calendar_today,
              ),
              const BotonMenu(
                texto: 'Perfil',
                ruta: '/perfil',
                icono: Icons.person,
              ),
              ListTile(
                leading:  const Icon(Icons.logout, color: Color(0xFF8BC34A), size: 40),
                title:  const Text(
                  'LogOut',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  await databaseNotifier.logOut();
                  context.push('/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
