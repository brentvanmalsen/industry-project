import 'package:flutter/material.dart';
import 'package:industry_project/home.dart';
import 'package:industry_project/onderwerp.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OnderwerpPage()),
            );
          },
          child: const Text('Onderwerpen screen'),
        ),
      ),
    );
  }
}
