import 'package:flutter/material.dart';

void overzicht() {
  runApp(const OverzichtPage());
}

class OverzichtPage extends StatelessWidget {
  const OverzichtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
