import 'package:flutter/material.dart';

class TextControl extends StatefulWidget {

@override
  State<StatefulWidget> createState() {
    return _TextControlState();
  }
}

class _TextControlState extends State<TextControl>{
  final buttonTexts = const [
    'Click me!',
    'This',
    'course',
    'is',
    'being',
    'so',
    'cool'
  ];
  int textIndex = 0;

  void _changeButtonText() {
      setState(() {
        textIndex += 1;
      });
  }

  void _resetButtonText() {
    setState(() {
      textIndex = 0;
    });
  }
   @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        child: Text(
          buttonTexts[textIndex],
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blue,
        onPressed: _changeButtonText,
      ),
    );
  }
}
