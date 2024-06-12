import 'package:flutter/material.dart';
import 'package:industry_project/overview.dart';
import 'package:industry_project/rating.dart';

void onderwerp() {
  runApp(const OnderwerpPage(rating: 0));
}

bool pressedButton = false;

class OnderwerpPage extends StatefulWidget {
  final double rating;

  const OnderwerpPage({super.key, required this.rating});

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
        appBar: AppBar(
          leading: IconButton(
            icon: const Image(
              image: AssetImage('assets/images/arrow_back.png'),
              height: 40,
              width: 40,
            ),
            iconSize: 70,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RatingPage(),
                ),
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 65, 130, 216),
              )),
              icon: const Icon(
                Icons.question_mark_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                //TODO Add onPressed code here!
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
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
                ],
              ),
            ),
            const SizedBox(height: 25),
            // Display the rating
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Text(
                widget.rating.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
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
                  const SizedBox(height: 35),
                  // Third row with 3 buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(width: 25),
                      // Button
                      SizedBox(
                        width: 50,
                        height: 35,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 65, 130, 216),
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2)))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OnderwerpPage(
                                  rating: 0,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            '+',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          // Text
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Text
                      const Text(
                        'Voeg nieuw onderwerp toe',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Third row with 3 buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(width: 25),
                      // Button
                      SizedBox(
                        width: 50,
                        height: 35,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 65, 130, 216),
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2)))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OnderwerpPage(
                                  rating: 0,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            '+',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          // Text
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Text
                      const Text(
                        'Voeg nieuw onderwerp toe',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  // Textfield
                  const SizedBox(
                      width: 300,
                      height: 120,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              maxLines: 10,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Korte samenvatting van gebeurtenis',
                              ),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 100),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OverzichtPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(307, 53),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Color.fromARGB(255, 65, 130, 216),
                      ),
                      child: const Text(
                        'Volgende',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
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
