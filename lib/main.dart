import 'package:flutter/material.dart';
// Importeer home.dart
import 'home.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InfoScreen(),
    );
  }
}

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  children: <Widget>[
                    _buildPage(
                      context,
                      'assets/logo.png',
                      'Welkom bij PeacePath',
                      'De app om je overstimulatie te monitoren en inzichten te geven.',
                    ),
                    _buildPage(
                      context,
                      'assets/begin.png',
                      'Communiceer',
                      'Als je last hebt van overstimulatie laat dit weten door op de grote knop te drukken op de home pagina.',
                    ),
                    _buildPage(
                      context,
                      'assets/invullen.png',
                      'Invullen',
                      'Vul vervolgens in bij welk onderwerp dit hoorde zoals: stad, werk, sport etc, of voeg een eigen onderwerp toe.',
                    ),
                    _buildPage(
                      context,
                      'assets/grafiek.png',
                      'Overzicht',
                      'Bekijk je inzichten en evalueer elke keer hoe je je voelde. Probeer patronen te herkennen en kijk of er bepaalde momenten, plaatsen of activiteiten zijn die je overstimuleren.',
                    ),
                    _buildPage(
                      context,
                      'assets/starten.png',
                      'Laten we starten!',
                      '',
                      showButton: true,
                    ),
                  ],
                ),
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: 5,
                effect: ExpandingDotsEffect(
                  dotHeight: 10.0,
                  dotWidth: 10.0,
                  activeDotColor: Colors.blue,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                  color: Color(0xFF4182DB),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(
      BuildContext context, String imagePath, String title, String description,
      {bool showButton = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          imagePath,
          width: 350,
          height: 350,
        ),
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
        if (showButton) SizedBox(height: 20),
        if (showButton)
          SizedBox(
            width: 325, // Make the button wider
            height: 50, // Make the button taller
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4182DB), // Background color
                foregroundColor: Colors.white, // Text color
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Border radius of 10
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Beginnen!'),
            ),
          ),
      ],
    );
  }
}
