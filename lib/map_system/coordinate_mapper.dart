import 'dart:math';
import 'dart:ui';

class CoordinateMapper {
  final double minLongitude;
  final double maxLongitude;
  final double minLatitude;
  final double maxLatitude;
  final double mapWidth;
  final double mapHeight;

  /// Globale Y-Verschiebung in Pixeln (positive Werte → nach unten)
  final double globalYOffset;

  CoordinateMapper({
    required this.minLongitude,
    required this.maxLongitude,
    required this.minLatitude,
    required this.maxLatitude,
    required this.mapWidth,
    required this.mapHeight,
    this.globalYOffset = 23, // Standard: keine Verschiebung
  });

  Offset gpsToPixel(double lat, double lon) {
    final x = ((lon - minLongitude) / (maxLongitude - minLongitude)) * mapWidth;
    double y = ((maxLatitude - lat) / (maxLatitude - minLatitude)) * mapHeight;

    // WIE VIEL die Punkte maximal verschoben werden sollen (in Pixeln)
    const double maxShift = 70;

    double factor = (y / mapHeight); // 0 (ganz oben) bis 1 (ganz unten)

    // Verschiebung zur Mitte:
    double shift = (0.5 - factor) * 2 * maxShift;
    y += shift;

    // Globale Justierung (manuell z. B. +30 oder -40 zum Feinabgleich)
    y += globalYOffset;

    return Offset(x, y);
  }
}
