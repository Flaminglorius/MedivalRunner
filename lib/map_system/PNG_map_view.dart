import 'package:flutter/material.dart';

class PNGMapView extends StatelessWidget {
  const PNGMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Karte")),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 50.0,
          child: SizedBox(
            width: 1200,
            height: 800,
            child: Stack(
            ),
          ),
        ),
      ),
    );
  }
}
