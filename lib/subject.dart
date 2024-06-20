import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:industry_project/final.dart';
import 'package:industry_project/rating.dart';

class OnderwerpPage extends StatefulWidget {
  final double rating;

  const OnderwerpPage({Key? key, required this.rating}) : super(key: key);

  @override
  _OnderwerpPageState createState() => _OnderwerpPageState();
}

class _OnderwerpPageState extends State<OnderwerpPage> {
  List<bool> buttonStates = List<bool>.generate(8, (index) => false);
  List<String> selectedTopics = [];
  String? selectedLocation;

  void _selectLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle accordingly
      return;
    }

    // Check permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, request permissions
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are still denied, handle accordingly
        return;
      }
    }

    // Get location once permissions are granted
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          selectedLocation = "${position.latitude}, ${position.longitude}";
        });
      } catch (e) {
        print('Error getting location: $e');
        // Handle errors, e.g., if location services are disabled or permission is denied
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Onderwerpen'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
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
              icon: const Icon(Icons.help),
              onPressed: () {
                // Handle onPressed
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 25),
              // Display the rating
              Container(
                height:
                    50, // Hoogte en breedte gelijk maken om een cirkel te behouden
                width: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle, // Instellen van de vorm als cirkel
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
                    // Buttons
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildButton(3, 'Stad'),
                        const SizedBox(width: 8),
                        buildButton(4, 'Auto rijden'),
                      ],
                    ),
                    const SizedBox(height: 5),
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
                    // Voeg nieuw onderwerp toe
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 65, 130, 216),
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                            color: Color.fromARGB(255, 65, 130, 216),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
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
                        icon: const Icon(
                          Icons.add,
                          color: Color.fromARGB(255, 65, 130, 216),
                        ),
                        label: const Text(
                          'Voeg nieuw onderwerp toe',
                          style: TextStyle(
                            color: Color.fromARGB(255, 65, 130, 216),
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Voeg locatie toe knop met overlay opties
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  const Color.fromARGB(255, 65, 130, 216),
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                color: Color.fromARGB(255, 65, 130, 216),
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // Show location options overlay
                              showLocationOptionsOverlay(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.add_location,
                                  color: Color.fromARGB(255, 65, 130, 216),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Voeg locatie toe',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 65, 130, 216),
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (selectedLocation != null)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                'Huidige locatie geselecteerd: $selectedLocation',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    // Tekstveld
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      width: 300,
                      height: 120,
                      child: TextField(
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Korte samenvatting van gebeurtenis',
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    // Volgende knop
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigeer naar een nieuwe pagina met de geselecteerde onderwerpen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FinalPage(
                                subject: selectedTopics,
                                number: widget.rating.toInt(),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(307, 53),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 65, 130, 216),
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
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: () {
          setState(() {
            buttonStates[index] = !buttonStates[index];
            if (buttonStates[index]) {
              selectedTopics.add(text); // Voeg geselecteerd onderwerp toe
            } else {
              selectedTopics
                  .remove(text); // Verwijder niet-geselecteerd onderwerp
            }
          });
        },
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void showLocationOptionsOverlay(BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject()! as RenderBox;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.my_location),
                title: const Text('Gebruik huidige locatie'),
                onTap: () {
                  Navigator.pop(context);
                  _selectLocation();
                },
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Zoek een locatie'),
                onTap: () {
                  Navigator.pop(context);
                  // Implementeer logica om een locatie te zoeken
                  // Deze functionaliteit moet nog worden toegevoegd
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: OnderwerpPage(rating: 0),
  ));
}
