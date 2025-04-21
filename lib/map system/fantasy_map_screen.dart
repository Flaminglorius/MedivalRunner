import 'package:flutter/material.dart';
import 'package:test_runner_app/services/csv_parser.dart'; // Der CSV-Parser
import 'package:test_runner_app/models/city.dart'; // Die City-Klasse

class FantasyMapScreen extends StatefulWidget {
  const FantasyMapScreen({super.key});

  @override
  FantasyMapScreenState createState() => FantasyMapScreenState();
}

class FantasyMapScreenState extends State<FantasyMapScreen> {
  late Future<List<City>> cities; // List of City objects

  @override
  void initState() {
    super.initState();
    cities = CsvParser.parseCities();  // Städte laden
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          debugPrint('Screen Size: $screenWidth x $screenHeight');

          // Originalgröße der PNG-Karte
          const imageWidth = 10928.0;
          const imageHeight = 4920.0;

          // Zoom berechnen, sodass Höhe der Karte auf Screenhöhe passt
          final initialScale = screenHeight / imageHeight;

          final transformationController = TransformationController();
          transformationController.value = Matrix4.identity()..scale(initialScale);

          return InteractiveViewer(
            minScale: 0.1,
            maxScale: 5.0,
            constrained: false,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            transformationController: transformationController,
            child: Stack(
              children: [
                Image.asset(
                  'assets/maps/Fonzaland_map.png',
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),

                // Städte als Marker setzen
                FutureBuilder<List<City>>(
                  future: cities,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text("Fehler beim Laden der Städte"));
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("Keine Städte gefunden"));
                    }

                    // Städte-Daten abrufen
                    List<City> citiesList = snapshot.data!;

                    // Marker für jede Stadt hinzufügen
                    return Stack(
                      children: citiesList.map((city) {
                        // Berechne die Position des Markers basierend auf den Koordinaten
                        double posX = (city.longitude - 10.0) * (screenWidth / 20.0); // Beispiel
                        double posY = (city.latitude - 50.0) * (screenHeight / 20.0); // Beispiel

                        return Positioned(
                          left: posX,
                          top: posY,
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("${city.name} wurde angetippt")),
                              );
                            },
                            child: Icon(
                              Icons.location_on,
                              size: 50,
                              color: Colors.red,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
