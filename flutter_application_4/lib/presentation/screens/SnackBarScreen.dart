import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackBarScreen extends StatelessWidget {
  static String name = 'SnackBarScreen';
  const SnackBarScreen({super.key});

  void showSnackbar (BuildContext context) {
    final snackbar = SnackBar(
      duration: const Duration(seconds: 1),
      content: const Text('Snackbarr'),
      action: SnackBarAction(
        label: 'X',
        onPressed: () {
          context.pop();
        },),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scaffolds')
      ),
      body: const _SnackBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showSnackbar(context);
        }, 
        label: const Text('Show snackbar')
      ),
    );
  }
}

class _SnackBar extends StatelessWidget {
  const _SnackBar({
    super.key,
  });

  void openDialog (BuildContext context) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text('WOWOWOWOW'),
        content: const Text('Ouyheaaaa'),
        actions: [
          TextButton(onPressed: () {
            context.pop();
          }, child: const Text(':(')),
          FilledButton(onPressed: () {}, child:  const Text('OWYEAAAAH'))
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          FilledButton(
            onPressed: () {
              showAboutDialog(
                context: context, 
                children: [const Text("textooooajsdlkfjasñkldfjñlk")],
              );
            }, 
            child: const Text('About Dialog')
          ),
          FilledButton.tonal(
            onPressed: () {
              openDialog(context);
            } , 
            child: const Text('custom dialog'))
        ],
      ),
    );
  }
}