import 'package:autoguard/presentation/entities/DataEntities/Turno.dart';
import 'package:autoguard/presentation/screens/AdminScreen.dart';
import 'package:autoguard/presentation/screens/LoginScreen.dart';
import 'package:autoguard/presentation/screens/MenuScreen.dart';
import 'package:autoguard/presentation/screens/MisTurnosUser.dart';
import 'package:autoguard/presentation/screens/PerfilScreen.dart';
import 'package:autoguard/presentation/screens/RegisterScreen.dart';
import 'package:autoguard/presentation/screens/RegistrarMedico.dart';
import 'package:autoguard/presentation/screens/RegistrationScreen.dart';
import 'package:autoguard/presentation/screens/sacar_turno/SacarTurnoScreen.dart';
import 'package:autoguard/presentation/screens/TurnoInfoScreen.dart';
import 'package:autoguard/presentation/screens/TurnoMedico.dart';
import 'package:autoguard/presentation/screens/TurnoPaciente.dart';
import 'package:autoguard/presentation/screens/TurnosMedico.dart';
import 'package:autoguard/presentation/screens/TurnosPaciente.dart';
import 'package:autoguard/presentation/screens/agenda/AgendaScreen.dart';
import 'package:autoguard/presentation/screens/sacar_turno/ConsultarEspecialista.dart';
import 'package:autoguard/presentation/screens/sacar_turno/SeleccionarFecha.dart';
import 'package:autoguard/presentation/screens/sacar_turno/SeleccionarHora.dart';
import 'package:autoguard/presentation/screens/sacar_turno/SeleccionarMedico.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: "/login", routes: [
  GoRoute(
    path: "/login",
    builder: (context, state) => LoginScreen(),
  ),
  GoRoute(
    path: "/registro",
    builder: (context, state) => Registerscreen(),
  ),
  GoRoute(
    path: "/home",
    builder: (context, state) => MenuScreen(),
  ),
  GoRoute(
    path: "/perfil",
    builder: (context, state) => PerfilScreen(),
  ),
  GoRoute(
      path: "/sacarTurno",
      builder: (context, state) => ConsultarEspecialista(),
      routes: [
        GoRoute(
            path: 'seleccionarEspecialista',
            builder: (context, state) => SeleccionarMedico()),
        GoRoute(
            path: 'seleccionarFecha',
            builder: (context, state) => SacarTurno()),
        GoRoute(
          path: 'seleccionarHora',
          builder: (context, state) => SeleccionarHora(),
        )
      ]),
     GoRoute(
    path: "/misTurnosUser",
    builder: (context, state) => MisTurnosUser(),
  ),
  GoRoute(
    path: '/misTurnosUser/:id',
    builder: (context, state) {
      final turno = state.extra as Turno;
      return TurnoInfoScreen(turno: turno);
    },
  ),
  GoRoute(
    path: "/turnos",
    builder: (context, state) => TurnosMedico(),
  ),
  GoRoute(
    path: "/detalleTurno",
    builder: (context, state) => TurnoMedico(turno: state.extra as String),
  ),
  GoRoute(
    path: "/detalleTurnoPaciente",
    builder: (context, state) => TurnoPaciente(turno: state.extra as String),
  ),
  GoRoute(
    path: "/consultas",
    builder: (context, state) => TurnosPaciente(),
  ),
  GoRoute(
    path: "/agenda",
    builder: (context, state) => AgendaScreen(),
  ),
    GoRoute(
      path: "/admin",
      builder: (context, state) => AdminScreen(),
    ),
    GoRoute(
      path: "/registroMedico",
      builder: (context, state) => RegistroMedicoScreen(),
    ),
]);
