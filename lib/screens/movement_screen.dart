import 'package:flutter/material.dart';

class FantasyMapScreen extends StatelessWidget {
  const FantasyMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fantasy Map')),
      body: Center(
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 5,
          child: Stack(
            children: [
              Image.asset('assets/maps/Fonzaland_map.png'),

              // Dummy POIs – später ersetzt durch dynamische CSV-Daten
              Positioned(
                left: 100, // Pixel von links
                top: 200, // Pixel von oben
                child: Icon(Icons.location_on, size: 40, color: Colors.red),
              ),
              Positioned(
                left: 250,
                top: 350,
                child: Icon(Icons.location_on, size: 40, color: Colors.blue),
              ),
              Positioned(
                left: 400,
                top: 120,
                child: Icon(Icons.location_on, size: 40, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}