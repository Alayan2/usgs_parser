///splits coordinates fro place mark string
String getCoordinates(var data, int i) {
  //indices for extracting coordinates
  const start = "coordinates: ";
  const end = "}, styleUrl";

  String stationDetails = data['Document']['Placemark'][i]
      .toString(); //string on each place mark's data
  final startIndex =
  stationDetails.indexOf(start); //startIndex for extracting coordinates
  final endIndex = stationDetails.indexOf(
      end, startIndex + start.length); //endIndex for extracting coordinates

  String coordinates =
  stationDetails.substring(startIndex + start.length, endIndex);

  // print(coordinates);

  return coordinates;
}