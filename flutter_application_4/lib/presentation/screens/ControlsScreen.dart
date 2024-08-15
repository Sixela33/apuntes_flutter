import 'package:flutter/material.dart';

enum Transportation {car, bike, bus, train}

class ControlsScreen extends StatelessWidget {
  static String name = 'ControlsScreen';
  const ControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('controls'),),
      body: const _ControlsScreen(),
    );
  }
}

class _ControlsScreen extends StatefulWidget {

  const _ControlsScreen({
    super.key,
  });

  @override
  State<_ControlsScreen> createState() => _ControlsScreenState();
}

class _ControlsScreenState extends State<_ControlsScreen> {
  bool isDeveloper = false;
  bool isLunch = false;
  Transportation selectedVehicle = Transportation.car;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SwitchListTile(
        title: const Text('Titulo'), 
        subtitle: const Text('subtitulo'), 
        value: isDeveloper, 
        onChanged: (value) {
          isDeveloper = !isDeveloper;
          setState(() {});
          }),
      CheckboxListTile(
        title: const Text('isLunch'),
        value: isLunch, 
        onChanged: (value) {
         isLunch = !isLunch; 
         setState(() {});
        }),
        ExpansionTile(
          title: const Text('pick your transport'),
          subtitle: const Text('Yubadubadubdub'),
          children: Transportation.values.map((transport) {
            return RadioListTile(
               title: 
                Text(transport.name), 
                groupValue: selectedVehicle, 
                value: transport, 
                onChanged: (value) {
                  selectedVehicle = value as Transportation;
                  setState(() {});
                }
              );
          }).toList(),
        )
      
      
    ],);
  }
}