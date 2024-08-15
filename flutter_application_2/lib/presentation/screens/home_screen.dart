import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String name = 'HomeScreen';

  final String username;

  HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Adjust as needed
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome'),
                  Text(username),
                ],
              ),
            ),
          ),
          Card(
            child: SizedBox(
              width: 300, // Adjust width as needed
              height: 300, // Adjust height as needed
              child: CalendarDatePicker(initialDate: DateTime.now(),firstDate: DateTime.utc(2024, 4, 1),lastDate: DateTime.utc(2024, 4, 30), onDateChanged: (date) {
                print(date);
              },),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(username: 'John Doe'),
  ));
}
