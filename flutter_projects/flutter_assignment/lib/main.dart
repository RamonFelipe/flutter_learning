import 'package:flutter/material.dart';
import 'package:flutter_assignment/textcontrol.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TextControl(),
      ),
    );
  }
}
