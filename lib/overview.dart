// ignore_for_file: avoid_print, prefer_const_constructors, unused_field, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// get data from database
import 'package:cloud_firestore/cloud_firestore.dart';

class OverzichtPage extends StatefulWidget {
  const OverzichtPage({super.key});

  @override
  State<OverzichtPage> createState() => _OverzichtPageState();
}

class _OverzichtPageState extends State<OverzichtPage> {
  // state of the flower
  int flowerState = 0;
  // art board creation for animation
  Artboard? _riveArtboard;
  // controller for animation
  StateMachineController? _controller;

  // listener from state.
  SMIInput<double>? _state;

  List<_Incidents> data2 = [];

  @override
  void initState() {
    super.initState();
    // gets the data from the database
    getData();
    // tries creating the artboard
    try {
      rootBundle.load('assets/flower.riv').then(
        (data) async {
          // imports the rive file
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;
          // sets the controller name from rive
          var controller =
              StateMachineController.fromArtboard(artboard, 'Grow');
          // if the controller is not null add the controller to the artboard
          if (controller != null) {
            artboard.addController(controller);
            _state = controller.findInput('State');
            // sets the state of the controller
            setState(() => _riveArtboard = artboard);
          }
        },
      );
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
      body: Column(children: [
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
              )),
              //info button
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
        // Subject buttons
        SizedBox(height: 25),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First row with 3 buttons
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
              // second row with 2 buttons
              SizedBox(
                height: 5,
              ),
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
              // third row with 3 buttons
              SizedBox(
                height: 5,
              ),
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
        //art board where animation is
        _riveArtboard == null
            // if artboard doesn't exist create sized box
            ? const SizedBox()
            // Else create container where artboard is in.
            : Container(
                width: 200,
                height: 200,
                child: Rive(
                    alignment: Alignment.center, artboard: _riveArtboard!)),
        SizedBox(height: 20),
        //graph
        SfCartesianChart(
          // sets axis
          primaryXAxis: CategoryAxis(
            labelPlacement: LabelPlacement.onTicks,
            interval: 1,
            majorGridLines: MajorGridLines(width: 1),
            // Customize labels to show only month
            labelIntersectAction:
                AxisLabelIntersectAction.hide, // Hide overlapping labels
          ),
          primaryYAxis: const NumericAxis(
            interval: 1, // Specify the interval between labels
            minimum: 0, // Set the minimum value of the axis
            maximum: 10, // Set the maximum value of the axis
          ),
          // sets up tooltip for more info
          tooltipBehavior: TooltipBehavior(enable: true),
          // creates the graph
          series: <CartesianSeries<_Incidents, String>>[
            LineSeries<_Incidents, String>(
              dataSource: data2,
              // Bottom of graph
              xValueMapper: (_Incidents incidentScale, _) {
                String date = incidentScale.date;
                String month =
                    date.split(' ')[0]; // Extract the first word (month)
                return month;
              },
              // Side of graph
              yValueMapper: (_Incidents incidentScale, _) =>
                  incidentScale.rating,
              name: 'Incident',
              //Dots on the line
              markerSettings: MarkerSettings(isVisible: true),
            ),
          ],
        ),
      ]),
    );
  }
}

class _Incidents {
  _Incidents(this.date, this.rating, this.subjects);

  final String date;
  final int rating;
  final List<String> subjects;
}
