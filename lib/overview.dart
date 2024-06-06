// ignore_for_file: avoid_print, prefer_const_constructors, unused_field, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OverzichtPage extends StatefulWidget {
  const OverzichtPage({Key? key}) : super(key: key);

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

  // list of incidents
  List<_IncidentLog> data = [
    _IncidentLog('Jan', 1),
    _IncidentLog('Feb', 2),
    _IncidentLog('Mar', 4),
    _IncidentLog('Apr', 3),
    _IncidentLog('May', 4),
    _IncidentLog('Jun', 4),
    _IncidentLog('Jul', 5),
    _IncidentLog('Aug', 6),
    _IncidentLog('Sep', 7),
    _IncidentLog('Oct', 8),
    _IncidentLog('Nov', 9),
    _IncidentLog('Dec', 10)
  ];

  // Indicates whether the flower is being shown or the chart
  bool _showingFlower = true;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        // Listen to swipe gestures
        onHorizontalDragEnd: (details) {
          // If the swipe gesture is from right to left
          if (details.primaryVelocity! < 0) {
            // Show chart
            setState(() {
              _showingFlower = false;
            });
          }
          // If the swipe gesture is from left to right
          else if (details.primaryVelocity! > 0) {
            // Show flower
            setState(() {
              _showingFlower = true;
            });
          }
        },
        child: SingleChildScrollView(
          // Wrap the content in SingleChildScrollView to allow vertical scrolling
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
                    // info button
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
              // Show flower or chart based on the flag
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
                            // sets axis
                            primaryXAxis: CategoryAxis(),
                            primaryYAxis: const NumericAxis(
                              interval:
                                  1, // Specify the interval between labels
                              minimum: 0, // Set the minimum value of the axis
                              maximum: 10, // Set the maximum value of the axis
                            ),
                            // sets up tooltip for more info
                            tooltipBehavior: TooltipBehavior(enable: true),
                            // creates the graph
                            series: <CartesianSeries<_IncidentLog, String>>[
                              LineSeries<_IncidentLog, String>(
                                dataSource: data,
                                // Bottom of graph
                                xValueMapper: (_IncidentLog incidentScale, _) =>
                                    incidentScale.month,
                                // Side of graph
                                yValueMapper: (_IncidentLog incidentScale, _) =>
                                    incidentScale.incidentScale,
                                name: 'incidentScale',
                                // Dots on the line
                                markerSettings: MarkerSettings(isVisible: true),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
              SizedBox(height: 20),
              // testing button
              ElevatedButton(
                  onPressed: () {
                    // sets the state of the flower
                    setState(() {
                      flowerState++;
                      _state?.value = flowerState.toDouble();
                    });
                  },
                  child: Text('increase')),
            ],
          ),
        ),
      ),
    );
  }
}

class _IncidentLog {
  _IncidentLog(this.month, this.incidentScale);

  final String month;
  final double incidentScale;
}

void main() {
  runApp(MaterialApp(
    home: OverzichtPage(),
  ));
}
