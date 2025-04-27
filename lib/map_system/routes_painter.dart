import 'package:flutter/material.dart';

class RoutesPainter extends CustomPainter {
  final List<List<Offset>> routes; // <-- WICHTIG: Typ ist Liste von Listen!

  RoutesPainter(this.routes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red // Farbe der Route
      ..strokeWidth = 5    // Dicke der Linie
      ..style = PaintingStyle.stroke;

    for (final path in routes) {
      if (path.length < 2) continue;

      final pathObject = Path()..moveTo(path[0].dx, path[0].dy);

      for (int i = 1; i < path.length; i++) {
        pathObject.lineTo(path[i].dx, path[i].dy);
      }

      canvas.drawPath(pathObject, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
