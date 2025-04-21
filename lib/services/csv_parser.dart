import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:test_runner_app/models/city.dart';

class CsvParser {
  // Methode, die CSV-Datei liest und in eine Liste von City-Objekten umwandelt
  static Future<List<City>> parseCities() async {
    // CSV-Datei aus den Assets laden
    String csvData = await rootBundle.loadString('assets/data/cities.csv');
    List<String> lines = LineSplitter.split(csvData).toList();

    // Zeilen in City-Objekte umwandeln
    List<City> cities = [];
    for (String line in lines) {
      List<String> csvRow = line.split(',');
      if (csvRow.length == 4) {  // Wir erwarten 4 Werte (Name, Lat, Lon, ID)
        cities.add(City.fromCsv(csvRow));
        print("Loaded cities: ${cities.length}"); // Debugging
      }
    }
    return cities;
  }
}
