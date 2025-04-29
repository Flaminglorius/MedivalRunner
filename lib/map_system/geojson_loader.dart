import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:test_runner_app/map_system/coordinate_mapper.dart';
import 'package:test_runner_app/map_system/route_data.dart';

class GeoJsonLoader {
  static Future<List<RouteData>> loadRoutesFromGeoJson(
      String path, CoordinateMapper mapper) async {
    final data = await rootBundle.loadString(path);
    final json = jsonDecode(data);

    final List<RouteData> routes = [];

    for (int i = 0; i < json['features'].length; i++) {
      final feature = json['features'][i];
      final geometry = feature['geometry'];
      final coords = geometry['coordinates'];
      final name = feature['properties']?['name'] ?? 'Route ${i + 1}';

      if (geometry['type'] == 'LineString') {
        final List<Offset> points = coords.map<Offset>((c) {
          final lon = (c[0] as num).toDouble();
          final lat = (c[1] as num).toDouble();
          return mapper.gpsToPixel(lat, lon);
        }).toList();

        routes.add(RouteData(name: name, points: points));
      }
    }

    return routes;
  }
}
