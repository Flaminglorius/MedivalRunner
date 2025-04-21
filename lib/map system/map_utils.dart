import 'dart:math';
import 'dart:ui';

class MapUtils {
  // Bildgröße deiner PNG-Karte
  static const double mapWidth = 10928;
  static const double mapHeight = 4920;

  // Virtuelles Koordinatensystem deiner Fantasy-Welt
  static const double mapLeftLon = 10.0;   // Westen
  static const double mapRightLon = 20.0;  // Osten
  static const double mapTopLat = 50.0;    // Norden
  static const double mapBottomLat = 40.0; // Süden

  /// Konvertiert GPS-Koordinaten in Pixelkoordinaten auf der PNG
  static Offset gpsToPixel(double lat, double lon) {
    double x = ((lon - mapLeftLon) / (mapRightLon - mapLeftLon)) * mapWidth;
    double y = ((mapTopLat - lat) / (mapTopLat - mapBottomLat)) * mapHeight;
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
