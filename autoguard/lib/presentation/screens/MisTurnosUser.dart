import 'package:autoguard/presentation/entities/DataEntities/Turno.dart';
import 'package:autoguard/presentation/entities/ThemeProvider.dart';
import 'package:autoguard/presentation/providers/dbProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final misTurnosProvider = FutureProvider<List<Turno>>((ref) {
  return ref.read(databaseNotifierProvider).getTurnosPorUsuario();
});

class MisTurnosUser extends StatelessWidget {
  const MisTurnosUser({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MisTurnosUser();
  }
}

class _MisTurnosUser extends ConsumerStatefulWidget {
  const _MisTurnosUser();

  @override
  _MisTurnosUserState createState() => _MisTurnosUserState();
}

class _MisTurnosUserState extends ConsumerState<_MisTurnosUser> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(misTurnosProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final misTurnosAsync = ref.watch(misTurnosProvider);
     final themeProvider = ref.watch(themeNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Turnos"),
        backgroundColor: themeProvider.primaryColor,
        elevation: 0,
      ),
      body: misTurnosAsync.when(
        error: (error, stackTrace) {
          return Center(child: Text('Error: $error'));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        data: (turnos) {
          if (turnos.isEmpty) {
            return const Center(child: Text('No hay turnos disponibles.'));
          }

          return ListView.builder(
            itemCount: turnos.length,
            itemBuilder: (context, index) {
              final turno = turnos[index];
              return Card(
                color: themeProvider.primaryColorLight,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text('Médico: ${turno.medicoName}'),
                  subtitle: Text('Fecha: ${turno.fechaHora}'),
                  trailing: Text(turno.estado.toString().split('.').last),
                  onTap: () {
                    context.push('/misTurnosUser/${turno.id}', extra: turno);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
