// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:industry_project/home.dart';
import 'package:industry_project/settings.dart';
import 'package:rive/rive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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

  int _selectedIndex = 0; // Set default selected index to 1 (Overview)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => OverzichtPage()),
        );
        break;
      case 1:
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
        break;

      case 2:
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    _displayData = data2;
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
        _displayData = [];
      } else if (filter == 'Week') {
        _displayData = [];
      } else if (filter == 'Month') {
        _displayData = [];
      } else if (filter == 'Year') {
        _displayData = data2;
      }
    });
  }

  void getData() async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('1');
      QuerySnapshot querySnapshot = await users.get();

      if (querySnapshot.docs.isNotEmpty) {
        data2.clear();

        for (var doc in querySnapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;
          var user = data['User'] as Map<String, dynamic>;
          var incidents = user['Incidents'] as Map<String, dynamic> ??
              {}; // Handle null case

          List<_Incidents> tempIncidents = [];
          var dateFormat = DateFormat('MMM dd, yyyy');

          incidents.forEach((key, value) {
            var subjectsMap = value['Subjects'] as Map<String, dynamic>? ??
                {}; // Handle null case
            List<String> subjectsList = subjectsMap.keys
                .map((key) => subjectsMap[key].toString())
                .toList();

            DateTime incidentDate = dateFormat.parse(value['Date'].toString());
            String month = DateFormat('MMM').format(incidentDate);

            tempIncidents
                .add(_Incidents(month, value['Rating'] ?? 0, subjectsList));
          });

          tempIncidents.sort((a, b) => DateFormat('MMM')
              .parse(a.date)
              .month
              .compareTo(DateFormat('MMM').parse(b.date).month));
          data2.addAll(tempIncidents);
        }

        if (data2.isNotEmpty) {
          _Incidents lastIncident = data2.last;
          flowerState = lastIncident.rating;
          _state?.value = flowerState.toDouble();

          print('Last Incident: $lastIncident');
        } else {
          print('The list is empty');
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
                            primaryXAxis: const CategoryAxis(
                              edgeLabelPlacement: EdgeLabelPlacement
                                  .none, // Remove any label shift
                              labelAlignment: LabelAlignment
                                  .start, // Align labels to the start
                            ),
                            primaryYAxis: const NumericAxis(
                              interval: 1,
                              minimum: 0,
                              maximum: 10,
                            ),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <CartesianSeries<_Incidents, String>>[
                              LineSeries<_Incidents, String>(
                                dataSource: _displayData,
                                xValueMapper: (_Incidents incidentScale, _) =>
                                    incidentScale.date,
                                yValueMapper: (_Incidents incidentScale, _) =>
                                    incidentScale.rating,
                                name: 'incidentScale',
                                markerSettings: MarkerSettings(isVisible: true),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
              SizedBox(height: 20),
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
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none, // Ensure the button can overflow the container
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
                    BoxShadow(
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

class _Incidents {
  _Incidents(this.date, this.rating, this.subjects);

  final String date;
  final int rating;
  final List<String> subjects;
}
