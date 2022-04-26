
String editUrlXML(String xmlString) {
  String alteredString = "";

  //indices for extracting coordinates
  const start = 'xAL:2.0">';
  const end = '</kml>';

  final startIndex =
  xmlString.indexOf(start); //startIndex for extracting coordinates
  final endIndex = xmlString.indexOf(
      end, startIndex + start.length); //endIndex for extracting coordinates

  alteredString = xmlString.substring(startIndex + start.length, endIndex);

  // String one = xmlString.substring(start);
  // print("xml string: " + alteredString);

  return alteredString;
}