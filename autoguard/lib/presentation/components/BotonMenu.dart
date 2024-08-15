import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BotonMenu extends StatelessWidget {
  final String texto;
  final String ruta;
  final IconData icono;

  const BotonMenu({required this.texto, required this.ruta, required this.icono, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icono, color: const Color(0xFF8BC34A), size: 40),
        title: Text(
          texto,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          context.push(ruta);
        },
      ),
    );
  }
}