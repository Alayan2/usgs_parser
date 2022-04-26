String getStationName(var data, int i) {
  String placemarkDetails = data['Document']['Placemark'][i]
      .toString(); //string on each place mark's data
  List stationSplit = placemarkDetails.split("name: ");
  List secondStationSplit = stationSplit[1].split(",");
  String stationName = secondStationSplit[0];
  return stationName;
}