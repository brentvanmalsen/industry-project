import 'package:flutter/material.dart';
import 'package:industry_project/overview.dart';
import 'package:industry_project/settings.dart';
import 'rating.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2; // Set default selected index to 1 (Settings)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => OverzichtPage()),
        );
        break;
      case 1:
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
        break;

      case 2:
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
    }
  }

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
      body: Column(
        children: [
          Center(
            child: SizedBox(
              width: 230,
              height: 230,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RatingPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(0),
                  backgroundColor: const Color(0xFF4183d9),
                ),
                child: Image.asset('assets/images/main_button.png'),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none, // Ensure the button can overflow the container
        children: [
          Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () => _onItemTapped(0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.list,
                            color: _selectedIndex == 0
                                ? Colors.blue
                                : Colors.grey),
                        Text('Overzichten',
                            style: TextStyle(
                                color: _selectedIndex == 0
                                    ? Colors.blue
                                    : Colors.grey)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 60), // Spacer for the home button
                Expanded(
                  child: InkWell(
                    onTap: () => _onItemTapped(1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.settings,
                            color: _selectedIndex == 1
                                ? Colors.blue
                                : Colors.grey),
                        Text('Instellingen',
                            style: TextStyle(
                                color: _selectedIndex == 1
                                    ? Colors.blue
                                    : Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10, // Adjust the position of the home button
            child: InkWell(
              onTap: () => _onItemTapped(2),
              child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.home, color: Colors.white, size: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
