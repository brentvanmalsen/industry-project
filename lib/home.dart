import 'package:flutter/material.dart';
import 'package:industry_project/overview.dart';
import 'package:industry_project/settings.dart';
import 'rating.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // Set default selected index to 1 (Settings)

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
        alignment: FractionalOffset.center,
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
                    const BoxShadow(
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
