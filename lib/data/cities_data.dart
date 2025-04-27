import 'package:test_runner_app/models/city.dart'; // Die City Klasse importieren
import 'package:test_runner_app/services/csv_parser.dart'; // CSV Parser importieren

Future<List<City>> getCities() async {
  return await CsvParser.parseCities(); // CSV-Daten einlesen
}
