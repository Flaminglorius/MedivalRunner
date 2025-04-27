import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_runner_app/map_system/route_layer.dart'; // Passe den Pfad an, falls nötig
import 'package:test_runner_app/services/map_utils.dart';  // Für MapWidth, MapHeight

class FantasyMapScreen extends StatelessWidget {
  const FantasyMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fantasy Map'),
      ),
      body: Stack(
        children: [
          InteractiveViewer(
            minScale: 0.5,
            maxScale: 5.0,
            child: SvgPicture.asset(
              'assets/maps/deine_svg_map.svg',  // <-- deinen Dateinamen hier anpassen
              width: MapUtils.mapWidth,
              height: MapUtils.mapHeight,
              fit: BoxFit.contain,
            ),
          ),
          const RouteLayer(), // <- HIER kommen die geladenen Routen!
        ],
      ),
    );
  }
}
