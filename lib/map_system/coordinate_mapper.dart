import 'package:flutter/material.dart';

class CoordinateMapper {
  final double minLongitude;
  final double maxLongitude;
  final double minLatitude;
  final double maxLatitude;
  final double mapWidth;
  final double mapHeight;

  CoordinateMapper({
    required this.minLongitude,
    required this.maxLongitude,
    required this.minLatitude,
    required this.maxLatitude,
    required this.mapWidth,
    required this.mapHeight,
  });

  Offset mapCoordinate(double longitude, double latitude) {
    final double x = ((longitude - minLongitude) / (maxLongitude - minLongitude)) * mapWidth;
    final double y = (1 - (latitude - minLatitude) / (maxLatitude - minLatitude)) * mapHeight;
    return Offset(x, y);
  }
}
