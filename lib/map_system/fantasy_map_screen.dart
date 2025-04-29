import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_runner_app/map_system/route_layer.dart';
import 'package:test_runner_app/services/map_utils.dart';
import 'package:test_runner_app/map_system/coordinate_mapper.dart'; // NEU hinzugefügt!

class FantasyMapScreen extends StatefulWidget {
  const FantasyMapScreen({super.key});

  @override
  State<FantasyMapScreen> createState() => _FantasyMapScreenState();
}

class _FantasyMapScreenState extends State<FantasyMapScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fantasy Map'),
      ),
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: MapUtils.mapWidth,
              height: MapUtils.mapHeight,
              child: InteractiveViewer(
                boundaryMargin: const EdgeInsets.all(1000),
                minScale: 0.01,
                maxScale: 10.0,
                constrained: false,
                child: Stack(
                  children: [
                    Container(
                      width: MapUtils.mapWidth,
                      height: MapUtils.mapHeight,
                      color: Colors.blueGrey.withAlpha(77),
                    ),
                    SvgPicture.asset(
                      'assets/maps/Fonzaland.svg',
                      width: MapUtils.mapWidth,
                      height: MapUtils.mapHeight,
                      fit: BoxFit.contain,
                    ),
                    RouteLayer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
