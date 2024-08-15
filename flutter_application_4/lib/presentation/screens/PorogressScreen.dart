import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressScreen extends StatelessWidget {
    static String name = 'progress screen';

  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress indicators'),
      ),
      body: const _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Text('Circular progress indicator'),
          SizedBox(height: 10,),
          CircularProgressIndicator(),
          SizedBox(height: 10,),
          Text('Controlled circular & linear progress indicator'),
          _ControlledIndicator()
        ],
      ),
    );
  }
}

class _ControlledIndicator extends StatelessWidget {
  const _ControlledIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircularProgressIndicator(value: 0.7),
        SizedBox(height: 10,),
        Expanded(
          child: LinearProgressIndicator(
            value: 0.7,
          ),
        )
      ],
    );
  }
}