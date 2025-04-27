import 'dart:math';
import 'dart:ui';

class MapUtils {
  // Bildgröße deiner PNG-Karte
  static const double mapWidth = 10928;
  static const double mapHeight = 4920;

  // Virtuelles Koordinatensystem deiner Fantasy-Welt
  static const double mapLeftLon = -24.0;   // Westen
  static const double mapRightLon = 24.0;   // Osten
  static const double mapTopLat = 12.0;     // Norden
  static const double mapBottomLat = -9.0;  // Süden

  /// Konvertiert GPS-Koordinaten in Pixelkoordinaten auf der PNG
  static Offset gpsToPixel(double lat, double lon) {
    double x = ((lon - mapLeftLon) / (mapRightLon - mapLeftLon)) * mapWidth;
    double xOffset = 20; // Fester horizontaler Offset
    x -= xOffset;

    double y = ((mapTopLat - lat) / (mapTopLat - mapBottomLat)) * mapHeight;

    // Dynamische Y-Korrektur je nach Position (nördlich = mehr Korrektur)
    double correctionStrength = 150; // ← Kannst du anpassen!
    double factor = y / mapHeight;  // 0 (oben) bis 1 (unten)
    double yCorrection = correctionStrength * pow(factor, 2);
    y -= yCorrection;

    print("gpsToPixel → lat: $lat, lon: $lon → x: ${x.toStringAsFixed(2)}, y: ${y.toStringAsFixed(2)} (Korrektur: ${yCorrection.toStringAsFixed(2)})");

    return Offset(x, y);
  }

  /// Konvertiert Pixelkoordinaten zurück in GPS-Koordinaten
  static LatLng pixelToGps(double x, double y) {
    double lon = mapLeftLon + (x / mapWidth) * (mapRightLon - mapLeftLon);
    double lat = mapTopLat - (y / mapHeight) * (mapTopLat - mapBottomLat);
    return LatLng(lat, lon);
  }

  /// Berechnet die Distanz (in Metern) zwischen zwei GPS-Koordinaten
  static double distanceInMeters(LatLng a, LatLng b) {
    const earthRadius = 6371000; // Meter
    double dLat = _degToRad(b.latitude - a.latitude);
    double dLon = _degToRad(b.longitude - a.longitude);

    double lat1 = _degToRad(a.latitude);
    double lat2 = _degToRad(b.latitude);

    double aCalc = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
    double c = 2 * atan2(sqrt(aCalc), sqrt(1 - aCalc));

    return earthRadius * c;
  }

  static double _degToRad(double degree) => degree * pi / 180;
}

class LatLng {
  final double latitude;
  final double longitude;
  LatLng(this.latitude, this.longitude);
}
