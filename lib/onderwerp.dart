import 'package:flutter/material.dart';

void onderwerp() {
  runApp(const OnderwerpPage());
}

bool pressedButton = false;

class OnderwerpPage extends StatefulWidget {
  const OnderwerpPage({super.key});

  @override
  _OnderwerpPageState createState() => _OnderwerpPageState();
}

class _OnderwerpPageState extends State<OnderwerpPage> {
  bool pressedButton = false;
  // List to hold the pressed state of each button
  List<bool> buttonStates = List<bool>.generate(8, (index) => false);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 70),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Onderwerpen',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 65, 130, 216),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.question_mark_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // First row with 3 buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildButton(0, 'Vakantie'),
                      const SizedBox(width: 8),
                      buildButton(1, 'Sociaal'),
                      const SizedBox(width: 8),
                      buildButton(2, 'Familie'),
                    ],
                  ),
                  const SizedBox(height: 5),
                  // Second row with 2 buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildButton(3, 'Stad'),
                      const SizedBox(width: 8),
                      buildButton(4, 'Auto rijden'),
                    ],
                  ),
                  const SizedBox(height: 5),
                  // Third row with 3 buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildButton(5, 'Ov'),
                      const SizedBox(width: 8),
                      buildButton(6, 'Onderwerp'),
                      const SizedBox(width: 8),
                      buildButton(7, 'Onderwerp'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(int index, String text) {
    return Container(
      width: 120,
      height: 35,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            buttonStates[index]
                ? const Color.fromARGB(255, 0, 50, 130)
                : const Color.fromARGB(255, 65, 130, 216),
          ),
        ),
        onPressed: () {
          setState(() {
            buttonStates[index] = !buttonStates[index];
          });
        },
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

@override
State<StatefulWidget> createState() {
  // TODO: implement createState
  throw UnimplementedError();
}
