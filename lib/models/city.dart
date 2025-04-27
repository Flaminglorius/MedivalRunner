class City {
  final String name;
  final double latitude;
  final double longitude;
  final double x;
  final double y;
  final int id;

  City({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.x,
    required this.y,
    required this.id,
  });

  factory City.fromCsv(List<String> csvRow) {
    return City(
      id: int.parse(csvRow[0]),
      name: csvRow[1],
      x: double.parse(csvRow[2]),
      y: double.parse(csvRow[3]),
      latitude: double.parse(csvRow[4]),
      longitude: double.parse(csvRow[5]),
    );
  }
}
