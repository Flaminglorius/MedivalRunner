import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:test_runner_app/services/map_utils.dart';
import 'package:test_runner_app/map_system/geojson_loader.dart'; // <- neu importieren, falls du die neue GeoJsonLoader hast

class RouteParser {
  static Future<List<RouteData>> loadRoutesFromGeoJson() async {
    final data = await rootBundle.loadString('assets/routes/Fonzaland_Routes.geojson');
    final json = jsonDecode(data);

    print("GeoJSON Inhalt geladen:");
    print(json);

    final List<RouteData> routes = [];

    for (int i = 0; i < json['features'].length; i++) {
      final feature = json['features'][i];
      final geometry = feature['geometry'];
      final coords = geometry['coordinates'];
      final name = feature['properties']?['name'] ?? 'Route ${i + 1}';

      if (geometry['type'] == 'LineString') {
        final List<Offset> points = coords.map<Offset>((c) {
          final lon = c[0];
          final lat = c[1];
          return MapUtils.gpsToPixel(lat, lon);
        }).toList();

        routes.add(RouteData(points: points));
      }
    }

    print("Fertig geladen: ${routes.length} Routen");

    return routes;
  }
}
