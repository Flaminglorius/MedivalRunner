import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:test_runner_app/models/city.dart';

class CsvParser {
  // Methode, die CSV-Datei liest und in eine Liste von City-Objekten umwandelt
  static Future<List<City>> parseCities() async {
    String csvData = await rootBundle.loadString('assets/data/Fonzaland_Burgs.csv');
    List<String> lines = LineSplitter.split(csvData).toList();

    // Header überspringen, falls vorhanden
    if (lines.isNotEmpty && lines.first.toLowerCase().contains("id")) {
      lines.removeAt(0);
    }
    List<City> cities = [];
    for (String line in lines) {
      List<String> csvRow = line.split(',');
      if (csvRow.length == 6) {  // Wir erwarten 6 Werte
        cities.add(City.fromCsv(csvRow));
      }
    }
    return cities;
  }
}
