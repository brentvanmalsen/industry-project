import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: <Widget>[
                _buildPage(
                  context,
                  'assets/logo.png',
                  'Welkom bij PeacePath',
                  'Hier krijg je een korte intrductie over de app.',
                ),
                _buildPage(
                  context,
                  'assets/begin.png',
                  'Features',
                  'ALs je last hebt van overstimulatie laat dit weten door op de grote knop te drukken op de home pagina.',
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
                  'Bekijk je overzicht',
                ),
                _buildPage(
                  context,
                  'assets/grafiek.png',
                  'Get Started',
                  'Let\'s get started!',
                  showButton: true,
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: 5,
            effect: WormEffect(
              dotHeight: 10.0,
              dotWidth: 10.0,
              activeDotColor: Colors.blue,
            ),
          ),
          SizedBox(height: 20),
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
          imagePath, // Make sure to add your images to the assets folder
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
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Text('Get Started'),
          ),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
