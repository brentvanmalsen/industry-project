import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:industry_project/home.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(MaterialApp(
    home: FinalPage(subject: ['placeholder'], number: 0), // Voorbeeldwaarden
  ));
}

class FinalPage extends StatefulWidget {
  final List<String> subject; // Placeholder voor het onderwerp
  final int number; // Placeholder voor het cijfer

  FinalPage({required this.subject, required this.number, String? location});

  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  int flowerState = 0;
  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<double>? _state;

  @override
  void initState() {
    super.initState();
    try {
      RiveFile.initialize();
      rootBundle.load('assets/flower.riv').then(
        (data) async {
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;
          var controller =
              StateMachineController.fromArtboard(artboard, 'Grow');
          if (controller != null) {
            artboard.addController(controller);
            _state = controller.findInput('State');
            flowerState = widget.number;
            _state?.value = flowerState.toDouble();
            setState(() => _riveArtboard = artboard);
          }
        },
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide the back button

        actions: [
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
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Informatie'),
                  content: const Text('Dit is de final pagina van de app.'),
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
        title: const Text('Final'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Onderwerp en Cijfer
            Column(
              children: [
                Text(
                  widget.subject.map((subject) {
                    return subject
                        .split(': ')[1]; // Split and take the second part
                  }).join(', '),
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      '${widget.number}',
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            // Bloem animatie placeholder
            Container(
              width: double.infinity,
              height: 450,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: _riveArtboard == null
                    ? const SizedBox()
                    : Rive(artboard: _riveArtboard!),
              ),
            ),
            Spacer(),
            // Volgende knop
            ElevatedButton(
              onPressed: () {
                // Navigatie naar de volgende pagina
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(307, 53),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Color.fromARGB(255, 65, 130, 216),
              ),
              child: const Text('Terug naar Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
