import 'package:flutter/material.dart';

void onderwerp() {
  runApp(const OnderwerpPage());
}

class OnderwerpPage extends StatelessWidget {
  const OnderwerpPage({super.key});

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
