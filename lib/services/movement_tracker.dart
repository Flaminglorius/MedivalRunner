import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:pedometer/pedometer.dart';

class MovementTracker {
  double totalDistance = 0.0;
  double fallbackDistance = 0.0;
  int stepCount = 0;
  StreamSubscription<Position>? _positionStream;
  StreamSubscription<StepCount>? _stepStream;
  Position? _lastPosition;

  void startTracking() {
    _listenToGPS();
    _listenToSteps();
  }

  void _listenToGPS() {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position pos) {
      if (_lastPosition != null) {
        double distance = Geolocator.distanceBetween(
          _lastPosition!.latitude,
          _lastPosition!.longitude,
          pos.latitude,
          pos.longitude,
        );
        if (distance > 0.5) {
          totalDistance += distance;
        }
      }
      _lastPosition = pos;
    });
  }

  void _listenToSteps() {
    _stepStream = Pedometer.stepCountStream.listen((StepCount stepCountData) {
      int newSteps = stepCountData.steps - stepCount;
      if (_lastPosition == null && newSteps > 0) {
        fallbackDistance += newSteps * 0.75; // ca. 0.75m pro Schritt
      }
      stepCount = stepCountData.steps;
    });
  }

  void stopTracking() {
    _positionStream?.cancel();
    _stepStream?.cancel();
  }

  double get currentDistance {
    return _lastPosition != null ? totalDistance : fallbackDistance;
  }
}
