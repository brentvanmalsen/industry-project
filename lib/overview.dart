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
  int flowerState = 0;
  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<double>? _state;

  final List<_IncidentLog> _yearData = [
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

  List<_IncidentLog> _displayData = [];
  bool _showingFlower = true;

  @override
  void initState() {
    super.initState();
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
                          'Overzicht',
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
