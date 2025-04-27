// lib/map_system/fantasy_map_screen.dart
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:test_runner_app/models/city.dart';
import 'package:test_runner_app/services/csv_parser.dart';
import 'package:test_runner_app/services/map_utils.dart';
import 'package:test_runner_app/services/route_parser.dart';
import 'package:test_runner_app/map_system/routes_painter.dart'; // <- hier ist dein Painter!

class FantasyMapScreen extends StatefulWidget {
  const FantasyMapScreen({super.key});

  @override
  State<FantasyMapScreen> createState() => _FantasyMapScreenState();
}

class _FantasyMapScreenState extends State<FantasyMapScreen> {
  List<City> cities = [];
  List<RouteData> routes = [];

  @override
  void initState() {
    super.initState();
    loadCities();
    loadRoutes();
  }

  Future<void> loadCities() async {
    final loadedCities = await CsvParser.parseCities();
    setState(() {
      cities = loadedCities;
    });
  }

  Future<void> loadRoutes() async {
    try {
      final data = await rootBundle.loadString('assets/routes/test_route.geojson');
      debugPrint(">> GeoJSON geladen! Länge: ${data.length}");

      final loadedRoutes = await RouteParser.loadRoutesFromGeoJson();
      debugPrint(">> Geladene Routen: ${loadedRoutes.length}");

      for (var route in loadedRoutes) {
        debugPrint("Route '${route.name}' hat ${route.path.length} Punkte.");
      }

      setState(() {
        routes = loadedRoutes;
      });
    } catch (e) {
      debugPrint("FEHLER beim Laden der GeoJSON: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    const imageWidth = 10928.0;
    const imageHeight = 4920.0;

    final transformationController = TransformationController();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final initialScale = screenHeight / imageHeight;
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
                if (routes.isNotEmpty)
                  CustomPaint(
                    size: const Size(imageWidth, imageHeight),
                    painter: RoutesPainter(routes.map((r) => r.path).toList()),
                  ),
                ...cities.map((city) {
                  final pixelCoordinates = MapUtils.gpsToPixel(city.latitude, city.longitude);
                  return Positioned(
                    left: pixelCoordinates.dx,
                    top: pixelCoordinates.dy,
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Stadt: ${city.name}")),
                        );
                      },
                      child: const Icon(
                        Icons.location_on,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
