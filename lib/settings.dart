import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'home.dart'; // Import HomePage
import 'overview.dart'; // Import OverviewPage

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Color(0xFF4182DB), // Achtergrondkleur van de Snackbar
        actionTextColor: Colors.white, // Tekstkleur van de Close knop
      ),
    ),
    home: Scaffold(
      body: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instellingen',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  final TextEditingController feedbackController = TextEditingController();
  int _selectedIndex = 1; // Set default selected index to 1 (Settings)

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    if (isDarkMode) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
  }

  void showFeedbackSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void sendFeedback(BuildContext context) async {
    String feedback = feedbackController.text;

    if (feedback.isEmpty) {
      showFeedbackSnackbar(context, 'Typ eerst feedback om te verzenden');
      return;
    }

    showFeedbackSnackbar(context, 'Feedback succesvol verzonden');

    String username = 'your-email@gmail.com';
    String password = 'your-app-specific-password';
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Your Name')
      ..recipients.add('recipient@example.com')
      ..subject = 'App Feedback'
      ..text = feedback;

    try {
      final sendReport = await send(message, smtpServer);
      print('Feedback sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Feedback not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OverviewPage()),
        );
        break;
      case 1:
        // Already on settings page
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
    }
  }

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
                  content:
                      const Text('Dit is de instellingenpagina van de app.'),
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
        title: const Text('Instellingen'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(31, 133, 133, 133),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Dark mode',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                            'Verander de kleuren van de app naar een donker thema'),
                      ),
                      Switch(
                        value: isDarkMode,
                        onChanged: (value) {
                          toggleDarkMode();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(31, 133, 133, 133),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Feedback',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Text(
                      'Mis je iets aan de app of is iets niet helemaal duidelijk? Laat het ons weten!'),
                  const SizedBox(height: 10),
                  TextField(
                    controller: feedbackController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Schrijf je feedback hier...',
                      filled: true, // Zorg ervoor dat het tekstvak gevuld is
                      fillColor:
                          Colors.white, // Achtergrondkleur van het tekstvak
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Ronde hoeken van 10px
                        borderSide: BorderSide
                            .none, // Verwijder de rand van het tekstvak
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                            0xFF4182DB), // Achtergrondkleur van de knop
                      ),
                      onPressed: () {
                        sendFeedback(context);
                      },
                      child: const Text(
                        'Verzend Feedback',
                        style: TextStyle(
                            color: Colors.white), // Tekstkleur van de knop
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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