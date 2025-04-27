import 'package:flutter/material.dart';
import 'package:test_runner_app/map_system/coordinate_mapper.dart';
import 'package:test_runner_app/services/map_utils.dart';
import 'package:test_runner_app/map_system/geojson_loader.dart';

class RouteLayer extends StatefulWidget {
  const RouteLayer({super.key});

  @override
  _RouteLayerState createState() => _RouteLayerState();
}

class _RouteLayerState extends State<RouteLayer> {
  List<RouteData> _routes = [];

  @override
  void initState() {
    super.initState();
    _loadRoutes();
  }

  void _loadRoutes() async {
    final mapper = CoordinateMapper(
      minLongitude: MapUtils.mapLeftLon,
      maxLongitude: MapUtils.mapRightLon,
      minLatitude: MapUtils.mapBottomLat,
      maxLatitude: MapUtils.mapTopLat,
      mapWidth: MapUtils.mapWidth,
      mapHeight: MapUtils.mapHeight,
    );

    final loadedRoutes = await GeoJsonLoader.loadRoutesFromGeoJson('assets/geojson/routes.geojson', mapper);
    setState(() {
      _routes = loadedRoutes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer( // Damit Routen-Overlay keine Touch-Events abfängt
      child: CustomPaint(
        painter: RoutePainter(routes: _routes),
        size: Size.infinite,
      ),
    );
  }
}

class RoutePainter extends CustomPainter {
  final List<RouteData> routes;

  RoutePainter({required this.routes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (var route in routes) {
      final points = route.points;
      for (int i = 0; i < points.length - 1; i++) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
