import 'package:flutter/material.dart';
import 'package:flutter_application_4/presentation/providers/counter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterScreen extends ConsumerWidget {
  static String name = "counter";
  CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int counterValue = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
      ),
      body: Center(
        child: Text(
          'Count $counterValue',
          style: TextStyle(fontSize: 45),
        ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            counterValue++;
              ref.read(counterProvider.notifier).state++;
        },
      ),
    );
  }
}