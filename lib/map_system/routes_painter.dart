import 'package:flutter/material.dart';
import 'package:test_runner_app/map_system/route_data.dart';

class RoutePainter extends CustomPainter {
  final List<RouteData> routes;

  RoutePainter({required this.routes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.withOpacity(0.7)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (var route in routes) {
      final points = route.points;
      for (int i = 0; i < points.length - 1; i++) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant RoutePainter oldDelegate) {
    return oldDelegate.routes != routes;
  }
}
