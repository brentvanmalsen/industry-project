import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          ClipOval(
            child: Container(
              color: const Color(0xFF4182D8),
              child: IconButton(
                icon: const Icon(Icons.person_add),
                color: Colors.white, // Color of the icon
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Uitnodiging versturen'),
                        content: const Text(
                            'Door mensen uit te nodigen, geef je hen de kans om inzicht te krijgen in jouw proces van overstimulatie. Dit kan hen helpen beter te begrijpen wat je doormaakt en hoe je hierop reageert. Verstuur daarom deze link naar degenen aan wie je dit proces wilt tonen, zodat ze een dieper inzicht krijgen in jouw ervaringen en behoeften. Op deze manier kunnen ze beter rekening houden met jouw situatie en je op een gepaste manier ondersteunen.'),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFF4182D8),
                            ),
                            child: const Text('Annuleren'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFF4182D8),
                            ),
                            child: const Text('Verstuur link'),
                            onPressed: () {
                              Share.share(
                                  'check out my website https://example.com',
                                  subject: 'Look what I made!');
                              Navigator.of(context).pop(); // Close the alert
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}
