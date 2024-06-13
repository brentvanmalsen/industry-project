import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// get data from database
import 'package:cloud_firestore/cloud_firestore.dart';

class OverzichtPage extends StatefulWidget {
  const OverzichtPage({Key? key}) : super(key: key);

  @override
  State<OverzichtPage> createState() => _OverzichtPageState();
}

class _OverzichtPageState extends State<OverzichtPage> {
  int flowerState = 0;
  Artboard? _riveArtboard;
  StateMachineController? _controller;

  SMIInput<double>? _state;

  List<_Incidents> data2 = [];
  List<_Incidents> _displayData = [];
  bool _showingFlower = true;
  @override
  void initState() {
    super.initState();
    // gets the data from the database
    getData();
    _displayData = _yearData;
    try {
      rootBundle.load('assets/flower.riv').then(
        (data) async {
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;
          var controller =
              StateMachineController.fromArtboard(artboard, 'Grow');
          if (controller != null) {
            artboard.addController(controller);
            _state = controller.findInput('State');
            setState(() => _riveArtboard = artboard);
          }
        },
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  void _updateFilter(String filter) {
    setState(() {
      if (filter == 'Day') {
        _displayData = [_IncidentLog('Day', 1)];
      } else if (filter == 'Week') {
        _displayData = [
          _IncidentLog('Week 1', 2),
          _IncidentLog('Week 2', 3),
          _IncidentLog('Week 3', 4),
          _IncidentLog('Week 4', 5)
        ];
      } else if (filter == 'Month') {
        _displayData = [
          _IncidentLog('Jan', 1),
          _IncidentLog('Feb', 2),
          _IncidentLog('Mar', 4),
          _IncidentLog('Apr', 3)
        ];
      } else if (filter == 'Year') {
        _displayData = _yearData;
      }
    });
  }

// gets the data from the database
  void getData() async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference users = FirebaseFirestore.instance.collection('1');

      // Get the documents from the collection
      QuerySnapshot querySnapshot = await users.get();

      if (querySnapshot.docs.isNotEmpty) {
        // Clear the data2 list before adding new data
        data2.clear();

        // Iterate over each document
        for (var doc in querySnapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;

          // Access the 'User' field
          var user = data['User'] as Map<String, dynamic>;

          // Access the 'Incidents' field within 'User'
          var incidents = user['Incidents'] as Map<String, dynamic>;

          // Iterate over each incident
          incidents.forEach((key, value) {
            // Extract subjects from the 'Subjects' map if it exists and is a map
            var subjectsMap = value['Subjects'] as Map<String, dynamic>?;

            // Create a list to store subjects
            List<String> subjectsList = [];

            // Add subjects to the list if they exist
            if (subjectsMap != null) {
              // Iterate over each key in the subjectsMap
              subjectsMap.keys.forEach((subjectKey) {
                // Add the subject to the list
                subjectsList.add(subjectsMap[subjectKey].toString());
              });
            }
            // Add the new incident to the data2 list
            data2.add(_Incidents(
                value['Date'].toString(), value['Rating'] ?? 0, subjectsList));
          });
          // Check if the list is not empty before accessing the last item
          if (data2.isNotEmpty) {
            // Get the last item from the list
            _Incidents lastIncident = data2.last;
            // Set the state of the flower
            flowerState = lastIncident.rating;
            // Set the state of the flower
            _state?.value = flowerState.toDouble();
          } else {
            print('The list is empty');
          }
        }
      } else {
        print('No documents found');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

// gets the data from the database
  void getData() async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference users = FirebaseFirestore.instance.collection('1');

      // Get the documents from the collection
      QuerySnapshot querySnapshot = await users.get();

      if (querySnapshot.docs.isNotEmpty) {
        // Clear the data2 list before adding new data
        data2.clear();

        // Iterate over each document
        for (var doc in querySnapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;

          // Access the 'User' field
          var user = data['User'] as Map<String, dynamic>;

          // Access the 'Incidents' field within 'User'
          var incidents = user['Incidents'] as Map<String, dynamic>;

          // Iterate over each incident
          incidents.forEach((key, value) {
            // Extract subjects from the 'Subjects' map if it exists and is a map
            var subjectsMap = value['Subjects'] as Map<String, dynamic>?;

            // Create a list to store subjects
            List<String> subjectsList = [];

            // Add subjects to the list if they exist
            if (subjectsMap != null) {
              // Iterate over each key in the subjectsMap
              subjectsMap.keys.forEach((subjectKey) {
                // Add the subject to the list
                subjectsList.add(subjectsMap[subjectKey].toString());
              });
            }
            // Add the new incident to the data2 list
            data2.add(_Incidents(
                value['Date'].toString(), value['Rating'] ?? 0, subjectsList));
          });
          // Check if the list is not empty before accessing the last item
          if (data2.isNotEmpty) {
            // Get the last item from the list
            _Incidents lastIncident = data2.last;
            // Set the state of the flower
            flowerState = lastIncident.rating;
            // Set the state of the flower
            _state?.value = flowerState.toDouble();
          } else {
            print('The list is empty');
          }
        }
      } else {
        print('No documents found');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            setState(() {
              _showingFlower = false;
            });
          } else if (details.primaryVelocity! > 0) {
            setState(() {
              _showingFlower = true;
            });
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 70),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Onderwerpen',
                          style: TextStyle(
                              fontSize: 35,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold),
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
              SizedBox(height: 25),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 65, 130, 216)),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Vakantie',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 0, 50, 130)),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Sociaal',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 65, 130, 216)),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Familie',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 65, 130, 216)),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Stad',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 65, 130, 216)),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Auto rijden',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 65, 130, 216)),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Ov',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 65, 130, 216)),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Onderwerp',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 65, 130, 216)),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Onderwerp',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              if (!_showingFlower)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => _updateFilter('Day'),
                          child: Text('Day'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => _updateFilter('Week'),
                          child: Text('Week'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => _updateFilter('Month'),
                          child: Text('Month'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => _updateFilter('Year'),
                          child: Text('Year'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              _showingFlower
                  ? (_riveArtboard == null
                      ? const SizedBox()
                      : Container(
                          width: 300,
                          height: 300,
                          child: Rive(
                              alignment: Alignment.center,
                              artboard: _riveArtboard!),
                        ))
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Grafiek',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 300,
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            primaryYAxis: const NumericAxis(
                              interval: 1,
                              minimum: 0,
                              maximum: 10,
                            ),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <CartesianSeries<_IncidentLog, String>>[
                              LineSeries<_IncidentLog, String>(
                                dataSource: _displayData,
                                xValueMapper: (_IncidentLog incidentScale, _) =>
                                    incidentScale.month,
                                yValueMapper: (_IncidentLog incidentScale, _) =>
                                    incidentScale.incidentScale,
                                name: 'incidentScale',
                                markerSettings: MarkerSettings(isVisible: true),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    flowerState++;
                    _state?.value = flowerState.toDouble();
                  });
                },
                child: Text('increase'),
              ),
              SizedBox(height: 20),
              // Page Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _showingFlower ? Colors.blue : Colors.grey,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: !_showingFlower ? Colors.blue : Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _Incidents {
  _Incidents(this.date, this.rating, this.subjects);

  final String date;
  final int rating;
  final List<String> subjects;
}
