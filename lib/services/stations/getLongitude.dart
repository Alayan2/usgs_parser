///splits coordinates string and converts to double
double getLong(String coordinates) {
  double lat;

  List coordinateSplit = coordinates.split(",");
  lat = double.parse(coordinateSplit[0]);

  return lat;
}