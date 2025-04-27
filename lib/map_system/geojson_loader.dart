import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'coordinate_mapper.dart';

class RouteData {
  final List<Offset> points;
  RouteData({required this.points});
}

class GeoJsonLoader {
  static Future<List<RouteData>> loadRoutesFromGeoJson(String assetPath, CoordinateMapper mapper) async {
    try {
      print('Lade GeoJSON von: $assetPath');
      final String jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      if (jsonMap['type'] != 'FeatureCollection') {
        print('Ungültiges GeoJSON-Format.');
        return [];
      }

      final List<RouteData> routes = [];

      for (var feature in jsonMap['features']) {
        final geometry = feature['geometry'];
        if (geometry['type'] == 'LineString') {
          final coordinates = geometry['coordinates'] as List<dynamic>;
          List<Offset> points = [];

          for (var coord in coordinates) {
            final lon = coord[0] as double;
            final lat = coord[1] as double;
            final mapped = mapper.mapCoordinate(lon, lat);

            points.add(mapped);
          }

          if (points.isNotEmpty) {
            routes.add(RouteData(points: points));
          }
        }
      }

      print('Fertig geladen: ${routes.length} Routen');
      return routes;
    } catch (e) {
      print('Fehler beim Laden der GeoJSON: $e');
      return [];
    }
  }
}
