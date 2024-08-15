import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}
//urlekian develocopit
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int counter = 0;

    Color _getBackgroundColor(int counter) {
      if (counter < 3) {
        return Colors.green;
      } else if (counter < 6) {
        return Colors.yellow;
      } else if (counter < 9) {
        return Colors.red;
      } else {
        return Colors.white;
      }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = _getBackgroundColor(counter);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome'),
              Text('Counter: $counter'),
              Padding(
                padding: const  EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    if(counter < 10) {
                      counter ++;
                    }
                    setState(() {});
                  }, 
                  child: const Text('data')),
                )
            ],
          ),
        ),
      ), 
    );
  }
}
