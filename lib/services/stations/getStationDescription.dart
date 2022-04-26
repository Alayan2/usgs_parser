//TODO edit description to include hyperlink to get flow and/or gage height info
//TODO find graph options
String getDescription(var data, int i) {
  String placemarkDetails = data['Document']['Placemark'][i]
      .toString(); //string on each place mark's data
  List descriptionSplit = placemarkDetails.split("description: ");
  String description = descriptionSplit[1];

  const start = "Site Name:</B>";
  const end = '</TD></TR><TR><TD><A HREF';

  final startIndex =
  description.indexOf(start); //startIndex for extracting coordinates
  final endIndex = description.indexOf(
      end, startIndex + start.length); //endIndex for extracting coordinates

  String siteDescription =
  description.substring(startIndex + start.length, endIndex);

  return siteDescription;
}