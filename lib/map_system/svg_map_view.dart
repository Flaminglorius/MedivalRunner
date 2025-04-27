import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgMapView extends StatelessWidget {
  const SvgMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SVG Map Test")),
      body: Center(
        child: InteractiveViewer(
          maxScale: 10.0,
          minScale: 0.1,
          child: SvgPicture.asset(
            'assets/maps/Fonzaland.svg', // ← dein Pfad
            fit: BoxFit.contain,
            width: 1000,
          ),
        ),
      ),
    );
  }
}
