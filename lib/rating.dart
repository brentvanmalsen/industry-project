import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: SliderPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _angle = 0.0; // De hoek van de slider

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              double dx = details.localPosition.dx;
              double dy = details.localPosition.dy;
              _angle =
                  atan2(dy - 115, dx - 115); // Bereken de hoek van de cursor
            });
          },
          child: Container(
            width: 230, // Breedte van de cirkel
            height: 230, // Hoogte van de cirkel
            child: CustomPaint(
              size: Size(230, 230),
              painter: CircleSliderPainter(angle: _angle),
            ),
          ),
        ),
      ),
    );
  }
}

class CircleSliderPainter extends CustomPainter {
  final double angle;

  CircleSliderPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCirclePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    Paint innerCirclePaint = Paint()
      ..color = Colors.blue // Blauwe kleur voor de binnenste cirkel
      ..style = PaintingStyle.fill;

    Paint thumbPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = min(centerX, centerY) - 20;

    canvas.drawCircle(Offset(centerX, centerY), radius, outerCirclePaint);

    double thumbX = centerX + radius * cos(angle);
    double thumbY = centerY + radius * sin(angle);

    canvas.drawCircle(Offset(thumbX, thumbY), 10, thumbPaint);

    canvas.drawCircle(Offset(centerX, centerY), 10, innerCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
