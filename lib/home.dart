import 'package:flutter/material.dart';
import 'rating.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 230,
          height: 230,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RatingPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: const EdgeInsets.all(0),
              backgroundColor: Color(0xFF4183d9),
            ),
            child: Image.asset('assets/images/main_button.png'),
          ),
        ),
      ),
    );
  }
}
