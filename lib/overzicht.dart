import 'package:flutter/material.dart';

class OverzichtPage extends StatelessWidget {
  const OverzichtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overzicht Page'),
      ),
      body: const Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
