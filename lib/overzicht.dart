import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OverzichtPage extends StatefulWidget {
  const OverzichtPage({super.key});

  @override
  State<OverzichtPage> createState() => _OverzichtPageState();
}

class _OverzichtPageState extends State<OverzichtPage> {
  int flowerState = 0;
  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<double>? _state;

  List<_SalesData> data = [
    _SalesData('Jan', 1),
    _SalesData('Feb', 3),
    _SalesData('Mar', 4),
    _SalesData('Apr', 3),
    _SalesData('May', 4),
    _SalesData('Jun', 4),
    _SalesData('Jul', 5),
    _SalesData('Aug', 6),
    _SalesData('Sep', 7),
    _SalesData('Oct', 8),
    _SalesData('Nov', 9),
    _SalesData('Dec', 10)
  ];

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 70),
        Text('Onderwerpen hier'),
        SizedBox(height: 20),
        _riveArtboard == null
            ? const SizedBox()
            : Container(
                width: 300,
                height: 300,
                child: Rive(
                    alignment: Alignment.center, artboard: _riveArtboard!)),
        SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              setState(() {
                flowerState++;
                _state?.value = flowerState.toDouble();
                print(_state);
              });
            },
            child: Text('increase')),
        SizedBox(height: 20),
        SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: const NumericAxis(
            interval: 1, // Specify the interval between labels
            minimum: 0, // Set the minimum value of the axis
            maximum: 10, // Set the maximum value of the axis
          ),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CartesianSeries<_SalesData, String>>[
            LineSeries<_SalesData, String>(
              dataSource: data,
              xValueMapper: (_SalesData sales, _) => sales.year,
              yValueMapper: (_SalesData sales, _) => sales.sales,
              name: 'Sales',
              markerSettings: MarkerSettings(isVisible: true),
            ),
          ],
        )
      ]),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
