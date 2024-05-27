import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rating'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SleekCircularSlider(
              onChangeEnd: (double value) {
                setState(() {
                  _rating = value;
                });
              },
              min: 0,
              max: 10,
              initialValue: _rating,
              appearance: CircularSliderAppearance(
                startAngle: 180,
                angleRange: 360,
                customColors: CustomSliderColors(
                  dotColor: Colors.blue,
                  progressBarColors: [Colors.blue],
                ),
                size: 200,
                customWidths: CustomSliderWidths(
                  progressBarWidth: 10,
                  handlerSize: 15,
                ),
                infoProperties: InfoProperties(
                  modifier: (double value) {
                    final rating = value.toStringAsFixed(1);
                    return '$rating/10';
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Rating: $_rating',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
