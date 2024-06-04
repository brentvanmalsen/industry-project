import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToInfoScreens();
  }

  _navigateToInfoScreens() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => InfoScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo.png', // Make sure to add your logo image to the assets folder
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          _buildPage(
            context,
            'assets/info1.png',
            'Welcome to our app!',
            'Here is some introductory information about the app.',
          ),
          _buildPage(
            context,
            'assets/info2.png',
            'Features',
            'Our app provides numerous features to help you achieve your goals.',
          ),
          _buildPage(
            context,
            'assets/info3.png',
            'Get Started',
            'Let\'s get started!',
            showButton: true,
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
          imagePath, // Make sure to add your images to the assets folder
          width: 150,
          height: 150,
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
