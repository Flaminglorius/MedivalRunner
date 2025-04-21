import 'package:flutter/material.dart';
// import 'package:pedometer/pedometer.dart';           // Nur falls MovementScreen aktiv verwendet wird
// import 'package:permission_handler/permission_handler.dart';
// import 'package:geolocator/geolocator.dart';

import 'package:test_runner_app/map system/fantasy_map_screen.dart';
// import 'package:test_runner_app/map system/PNG_map_view.dart'; // Nicht mehr verwendet

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fantasy Läuferapp',
      theme: ThemeData.dark(), // Optional: Fantasy-Stimmung durch Dark Theme
      home: const FantasyMapScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Behalte MovementScreen als Test-Screen für später
/*
class MovementScreen extends StatefulWidget {
  const MovementScreen({super.key});

  @override
  State<MovementScreen> createState() => _MovementScreenState();
}

class _MovementScreenState extends State<MovementScreen> {
  late Stream<StepCount> _pedometerStream;
  int _steps = 0;

  Position? _lastPosition;
  double _distance = 0.0;

  @override
  void initState() {
    super.initState();
    _initPedometer();
    _initGpsTracking();
  }

  Future<void> _initPedometer() async {
    var status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      _pedometerStream = Pedometer.stepCountStream;
      _pedometerStream.listen((StepCount stepCount) {
        setState(() {
          _steps = stepCount.steps;
        });
      });
    } else {
      debugPrint("Pedometer-Permission not granted");
    }
  }

  Future<void> _initGpsTracking() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('GPS nicht aktiviert.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('GPS-Berechtigung verweigert.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint('GPS dauerhaft verweigert.');
      return;
    }

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    ).listen((Position position) {
      if (_lastPosition != null) {
        final double delta = Geolocator.distanceBetween(
          _lastPosition!.latitude,
          _lastPosition!.longitude,
          position.latitude,
          position.longitude,
        );
        setState(() {
          _distance += delta;
        });
      }
      _lastPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movement Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Steps: $_steps', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            Text('Distanz: ${_distance.toStringAsFixed(2)} m', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FantasyMapScreen()),
                );
              },
              child: const Text('Karte anzeigen'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
