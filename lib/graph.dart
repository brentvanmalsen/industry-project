import 'package:flutter/material.dart';

void grafiek() {
  runApp(const GrafiekPage());
}

class GrafiekPage extends StatelessWidget {
  const GrafiekPage({super.key});

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
