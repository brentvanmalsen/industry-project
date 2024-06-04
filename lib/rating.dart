import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class RatingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/images/arrow_back.png', // Afbeelding van terugpijl
            height: 40, // Hoogte van de afbeelding
            width: 40, // Breedte van de afbeelding
          ),
          iconSize: 70, // Grootte van het pictogram instellen
          onPressed: () {
            Navigator.pop(context); // Terug naar vorige pagina
          },
        ),
        // Verwijder de tekst "Rating" uit de app-balk
        // title: Text('Rating'),
      ),
      body: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment
              .start, // Elementen verticaal naar boven uitlijnen
          children: [
            SizedBox(height: 30), // Meer ruimte toevoegen bovenaan
            Container(
              padding: EdgeInsets.all(20),
              child: const Column(
                children: [
                  Text(
                    'Overstimulatie status',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25, // Lettergrootte 25
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Gebruik de slider van 0 tot 100% om aan te geven hoeveel je op dit moment wordt beïnvloed door overstimulatie.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15, // Lettergrootte 14
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50), // Ruimte toevoegen tussen de tekst en slider
            Center(
              child: SizedBox(
                width: 240,
                height: 240,
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    startAngle: 270, // Begin bovenaan
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
                  min: 0, // Minimumwaarde instellen op 0
                  max: 100, // Maximumwaarde instellen op 100
                  initialValue: 0, // Beginwaarde instellen op 0
                  onChange: (double value) {
                    print(value);
                  },
                ),
              ),
            ),
            SizedBox(
                height: 100), // Ruimte toevoegen tussen de slider en de knop
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Voeg hier de gewenste functionaliteit toe voor de knop
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(307, 53), // Breedte en hoogte instellen
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Randradius instellen
                  ),
                  backgroundColor:
                      Color(0xFF4182DB), // Achtergrondkleur instellen
                ),
                child: const Text(
                  'Volgende',
                  style: TextStyle(
                    color: Colors.white, // Tekstkleur wit
                    fontSize: 16, // Lettergrootte 16
                    fontWeight: FontWeight.bold, // Vetgedrukt
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
