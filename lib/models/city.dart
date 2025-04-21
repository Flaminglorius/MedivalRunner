class City {
  final String name;
  final double latitude;
  final double longitude;
  final int id;

  City({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.id,
  });

  // Factory-Methode zum Erstellen einer City aus einer CSV-Zeile
  factory City.fromCsv(List<String> csvRow) {
    return City(
      name: csvRow[0],          // Der Name der Stadt
      latitude: double.parse(csvRow[1]), // Breitengrad
      longitude: double.parse(csvRow[2]), // Längengrad
      id: int.parse(csvRow[3]),  // ID der Stadt
    );
  }
}
