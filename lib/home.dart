import 'package:flutter/material.dart';
import 'package:share/share.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add,
                color: Color(0xFF4182D8)), // Blauw icoontje
            tooltip: 'Invite People',
            onPressed: () {
              // Show the AlertDialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Uitnodiging versturen'),
                    content: Text(
                        "Door mensen uit te nodigen, geef je hen de kans om inzicht te krijgen in jouw proces van overstimulatie. Dit kan hen helpen beter te begrijpen wat je doormaakt en hoe je hierop reageert. Verstuur daarom deze link naar degenen aan wie je dit proces wilt tonen, zodat ze een dieper inzicht krijgen in jouw ervaringen en behoeften. Op deze manier kunnen ze beter rekening houden met jouw situatie en je op een gepaste manier ondersteunen."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the AlertDialog
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Color(0xFF4182D8), // Background color
                          textStyle: TextStyle(
                            color: Colors.white, // Text color
                            fontWeight: FontWeight.bold, // Bold text
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Colors.white), // Set text color to white
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Close the AlertDialog and open Share to share the link
                          Navigator.pop(context);
                          final String inviteLink =
                              'https://yourapp.com/invite';
                          Share.share(
                              'Join our app using this link: $inviteLink');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Color(0xFF4182D8), // Background color
                          textStyle: TextStyle(
                            color: Colors.white, // Text color
                            fontWeight: FontWeight.bold, // Bold text
                          ),
                        ),
                        child: Text(
                          'Verstuur link',
                          style: TextStyle(
                              color: Colors.white), // Set text color to white
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: const Text('Welcome to Home Page!'),
      ),
    );
  }
}
