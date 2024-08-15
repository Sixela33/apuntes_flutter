
import 'package:autoguard/presentation/providers/userProvider.dart';
import 'package:autoguard/presentation/screens/MenuMedico.dart';
import 'package:autoguard/presentation/screens/MenuPaciente.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(userProvider);

      return user!.esMedico! ? const MenuMedico() : const MenuPaciente();
  
  }
}
