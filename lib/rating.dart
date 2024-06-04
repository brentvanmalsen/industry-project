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
        leading: IconButton(
          icon: Image.asset(
            'assets/images/arrow_back.png',
            height: 40,
            width: 40,
          ),
          iconSize: 70,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.all(20),
            child: const Column(
              children: [
                Text(
                  'Overstimulatie status',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Gebruik de slider van 0 tot 100% om aan te geven hoeveel je op dit moment wordt beïnvloed door overstimulatie.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: SizedBox(
              width: 240,
              height: 240,
              child: SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  startAngle: 270,
                  angleRange: 360,
                  customColors: CustomSliderColors(
                    progressBarColors: [Colors.blue, Colors.blue],
                    trackColor: Colors.blue.withOpacity(0.2),
                  ),
                  size: 240,
                  customWidths: CustomSliderWidths(
                    progressBarWidth: 25,
                  ),
                ),
                min: 0,
                max: 100,
                initialValue: 0,
                onChange: (double value) {
                  setState(() {
                    _rating = value;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 100),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                // Hier wordt de waarde van _rating afgerond en geprint in de terminal
                print('De ingevoerde rating is: ${_rating.round()}');
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(307, 53),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Color(0xFF4182DB),
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
    );
  }
}
