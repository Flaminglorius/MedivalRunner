import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_runner_app/map_system/route_layer.dart';
import 'package:test_runner_app/services/map_utils.dart';

class FantasyMapScreen extends StatelessWidget {
  const FantasyMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TransformationController transformationController = TransformationController();

    // Initiale Zoom und Position setzen
    transformationController.value = Matrix4.identity()
      ..translate(-MapUtils.mapWidth / 4, -MapUtils.mapHeight / 4)
      ..scale(0.3); // Startzoom (0.3 = 30% rausgezoomt)

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fantasy Map'),
      ),
      body: Center(
        child: SizedBox(
          width: MapUtils.mapWidth,
          height: MapUtils.mapHeight,
          child: InteractiveViewer(
            transformationController: transformationController,
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
                const RouteLayer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
