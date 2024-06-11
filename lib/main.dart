import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:industry_project/firebase_options.dart';
import 'package:industry_project/overview.dart';
import 'package:industry_project/subject.dart';

// Importeer home.dart
import 'home.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OverzichtPage()),
              );
            },
            child: const Text('Go to Overzicht Page'),
          ),
        ],
      ),
    );
  }
}
