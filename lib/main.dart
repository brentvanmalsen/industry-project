import 'package:flutter/material.dart';
import 'package:industry_project/onderwerp.dart';
// Importeer home.dart
import 'home.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MainHomePage(), // Verander naar de nieuwe home-pagina
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()), // Navigeer naar HomePage
              );
            },
            child: Text(
                'Temporary button to Home'), // Simpele knop toegevoegd om tijdelijk de rating pagina te weergeven
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OnderwerpPage()),
              );
            },
            child: const Text('Onderwerpen screen'),
          ),
        ],
      ),
    );
  }
}
