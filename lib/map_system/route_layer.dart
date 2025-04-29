import 'package:flutter/material.dart';
import 'package:test_runner_app/services/map_utils.dart';
import 'package:test_runner_app/map_system/routes_painter.dart';
import 'package:test_runner_app/map_system/geojson_loader.dart';
import 'package:test_runner_app/map_system/coordinate_mapper.dart';
import 'package:test_runner_app/map_system/route_data.dart';



class RouteLayer extends StatefulWidget {
  const RouteLayer({super.key});

  @override
  RouteLayerState createState() => RouteLayerState();
}



class RouteLayerState extends State<RouteLayer> {
  List<RouteData> _routes = [];


  @override
  void initState() {
    super.initState();
    _loadRoutes();
  }


  void _loadRoutes() async {
    final mapper = CoordinateMapper(
      minLongitude: MapUtils.mapLeftLon,
      maxLongitude: MapUtils.mapRightLon,
      minLatitude: MapUtils.mapBottomLat,
      maxLatitude: MapUtils.mapTopLat,
      mapWidth: MapUtils.mapWidth,
      mapHeight: MapUtils.mapHeight,
    );

    final loadedRoutes = await GeoJsonLoader.loadRoutesFromGeoJson('assets/routes/Fonzaland_Routes.geojson', mapper);
    setState(() {
      _routes = loadedRoutes;
    });
  }


  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: MapUtils.mapWidth,
        height: MapUtils.mapHeight,
        child: CustomPaint(
          painter: RoutePainter(routes: _routes), // <- benutzt den richtigen externen Painter!
        ),
      ),
    );
  }
}