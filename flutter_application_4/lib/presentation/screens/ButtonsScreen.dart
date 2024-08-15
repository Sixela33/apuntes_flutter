import 'package:flutter/material.dart';

class ButtonsScreen extends StatelessWidget {
  static String name = 'ButtonsScreen';

  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons'),
        ),
        body: const _ButtonView(),
    );
  }
}

class _ButtonView extends StatelessWidget {
  const _ButtonView({super.key,});


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Wrap(
          spacing: 10,
          children: [
          ElevatedButton(onPressed: () {}, child: const Text('elevated button')),
          ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.alarm), label: const Text('ElevatedButton icon')),
          FilledButton(onPressed: () {}, child: const Text('filledButton')),
          FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.alarm), label: const Text('Filled button Icon')),
          TextButton(onPressed: () {}, child: const Text('Text Button')),
          TextButton.icon(onPressed: () {}, icon: const Icon(Icons.text_decrease_outlined), label: const Text('TextButtonIcon')),
          IconButton(onPressed: () {}, icon:  const Icon(Icons.text_decrease_outlined)),
          IconButton(onPressed: () {}, icon:  const Icon(Icons.text_decrease_outlined), 
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(colors.primary)),)
          ],),
      ),
    );
  }
}