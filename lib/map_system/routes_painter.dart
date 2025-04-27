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
    final x = ((lon - mapLeftLon) / (mapRightLon - mapLeftLon)) * mapWidth;

    // Mercator Projektion für Y
    final latRad = lat * (pi / 180); // Grad in Bogenmaß umrechnen
    final mercN = log(tan((pi / 4) + (latRad / 2)));
    final fullMercNTop = log(tan((pi / 4) + (mapTopLat * pi / 180) / 2));
    final fullMercNBottom = log(tan((pi / 4) + (mapBottomLat * pi / 180) / 2));
    final y = ((fullMercNTop - mercN) / (fullMercNTop - fullMercNBottom)) * mapHeight;

    return Offset(x, y);
  }

  /// Konvertiert Pixelkoordinaten zurück in GPS-Koordinaten
  static LatLng pixelToGps(double x, double y) {
    double lon = mapLeftLon + (x / mapWidth) * (mapRightLon - mapLeftLon);

    final fullMercNTop = log(tan((pi / 4) + (mapTopLat * pi / 180) / 2));
    final fullMercNBottom = log(tan((pi / 4) + (mapBottomLat * pi / 180) / 2));
    final mercN = fullMercNTop - (y / mapHeight) * (fullMercNTop - fullMercNBottom);
    final lat = (2 * atan(exp(mercN)) - pi / 2) * (180 / pi);

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
