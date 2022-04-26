///splits coordinates string and converts to double
double getLat(String coordinates) {
  double lat;

  List coordinateSplit = coordinates.split(",");
  lat = double.parse(coordinateSplit[1]);

  return lat;
}