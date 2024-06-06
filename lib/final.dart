import 'package:flutter/material.dart';

class FinalPage extends StatelessWidget {
  final String subject; // Placeholder voor het onderwerp
  final int number; // Placeholder voor het cijfer

  FinalPage({required this.subject, required this.number});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Informatie'),
                  content: const Text('Dit is de final pagina van de app.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        title: const Text('Final'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Onderwerp en Cijfer
            Column(
              children: [
                Text(
                  subject,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      '$number',
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            // Bloem animatie placeholder
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Animatie van een bloem',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            Spacer(),
            // Volgende knop
            ElevatedButton(
              onPressed: () {
                // Navigatie naar de volgende pagina
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Volgende',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // Witte tekst
                minimumSize: Size(double.infinity, 50), // Uitgerekte knop
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volgende Pagina'),
      ),
      body: Center(
        child: Text('Dit is de volgende pagina.'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FinalPage(
        subject: 'Onderwerp Placeholder', number: 5), // Voorbeeldwaarden
  ));
}
