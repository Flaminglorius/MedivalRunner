import 'package:flutter/material.dart';
import 'package:test_runner_app/map_system/fantasy_map_screen.dart';
import 'package:test_runner_app/map_system/svg_map_view.dart'; // NEU

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fantasy Läuferapp',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Willkommen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FantasyMapScreen()),
                );
              },
              child: const Text("PNG Karte anzeigen"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SvgMapView()),
                );
              },
              child: const Text("SVG Karte anzeigen"),
            ),
          ],
        ),
      ),
    );
  }
}
