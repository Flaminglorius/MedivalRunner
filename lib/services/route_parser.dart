import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:test_runner_app/services/map_utils.dart';

class RouteData {
  final String name;
  final List<Offset> path;

  RouteData({required this.name, required this.path});
}

class RouteParser {
  static Future<List<RouteData>> loadRoutesFromGeoJson() async {
    final data = await rootBundle.loadString('assets/routes/test_route.geojson');
    final json = jsonDecode(data);

    print("GeoJSON Inhalt geladen:");
    print(json); // <-- DAS HIER IST NEU!

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

        routes.add(RouteData(name: name, path: points));
      }
    }

    print("Fertig geladen: ${routes.length} Routen"); // <-- Auch SEHR WICHTIG!

    return routes;
  }
}
