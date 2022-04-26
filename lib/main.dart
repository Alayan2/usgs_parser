import 'dart:async';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:usgs_parser/services/stations/alteredStationsXML.dart';
import 'package:usgs_parser/services/stations/getCoordinates.dart';
import 'package:usgs_parser/services/stations/getLongitude.dart';
import 'package:usgs_parser/widgets/customgraph.dart';
import 'package:usgs_parser/services/stations/getLatitude.dart';
import 'package:usgs_parser/services/stations/getStationDescription.dart';
import 'package:usgs_parser/services/stations/getStationName.dart';
import 'package:xml2json/xml2json.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'widgets/customscrollviewcontent.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;

  //TODO: figure out a center for map
  final LatLng _center = const LatLng(28.5384, -81.3789); //center for map focus

  Map<String, dynamic> raw = {}; //
  Map<MarkerId, Marker> markers =
      <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS
  MarkerId? selectedMarker;
  LatLng? markerPosition;
  String cardTitle = "Click Marker To Display Data";
  double cardHeight = 0.1;
  late DraggableScrollableSheet bottomSheet;
  bool flowSelection = false;
  String dataURL = "";
  String stationID ="";

  List<FlSpot> values = [];



  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  /// When CameraPosition changes, method listens for zoom level
  /// of 11. At zoom level == 11, pushes webservice call for stations
  /// within coordinate range.

  void _onGeoChanged(CameraPosition position) {
    //pulls center coordinates from user map
    //manipulates coordinate string to separate lat and long
    //when zoom level == 11 or less
    //TODO consider changing zoom range
    if (position.zoom >= 11) {
      List _positionString = position.target.toString().split("(");
      List _latString = _positionString[1].split(", ");
      int length = _latString[1].length;
      String _longString = _latString[1].substring(0, length - 9);

      //pulls center coordinates from user map
      double _latFocus = double.parse(_latString[0].substring(0, length - 10));
      double _longFocus = double.parse(_longString);

      //calculate coordinate ranges for webservice call
      double northernLat = double.parse((_latFocus + 0.2).toStringAsFixed(6));
      double southernLat = double.parse((_latFocus - 0.2).toStringAsFixed(6));
      double westernLong = double.parse((_longFocus - 0.2).toStringAsFixed(6));
      double easternLong = double.parse((_longFocus + 0.2).toStringAsFixed(6));

      //sites url works, next step is to parse website for stations - check the format
      String sitesUrl = "http://waterservices.usgs.gov/nwis/site/?format=gm," +
          "1.0&bBox=" +
          westernLong.toString() +
          "," +
          southernLat.toString() +
          "," +
          easternLong.toString() +
          "," +
          northernLat.toString() +
          "&siteType=ST&siteStatus=" +
          "active&hasDataTypeCd=dv";

      // print("sitesUrl: " + sitesUrl);

      getMarkers(sitesUrl);
      cardHeight = 0.1;

      // print("url: " + sitesUrl);
      // print("zoom: " + position.zoom.toString());

      // print("lat: " + _latFocus.toString());
      // print("long: " + _longFocus.toString());
    }
  }

  void getFlowData(String sitesURL) async {

    List<String> data = [] ;

    String xmlString = await http.read(Uri.parse(sitesURL));

    // print(xmlString);


  }
  Future<Map<MarkerId, Marker>> getMarkers(String sitesURL) async {
    //markers to place on map

    String xmlString = await http.read(Uri.parse(sitesURL));

    final String response = editUrlXML(xmlString);

    // final String response = await rootBundle.loadString('assets/sites.xml');
    var stationName;
    var description;
    double lat;
    double long;

    //converts xml to json format
    Xml2Json xml2json = Xml2Json();
    xml2json.parse(response);
    var json = xml2json.toParker();

    var data = jsonDecode(json);

    var jsonLength = data['Document']['Placemark'].length;

    //loops through json to add all marker data
    for (int i = 0; i < jsonLength; i++) {
      String coordinates = getCoordinates(data, i);
      lat = getLat(coordinates);
      long = getLong(coordinates);

      description = getDescription(data, i);

      stationName = getStationName(data, i);

      _add(stationName, description, lat, long);
    }

    return markers;
  }

  void _add(String stationName, String description, double lat, double long) {
    // var markerIdVal = stationName;
    // final MarkerId markerId = MarkerId(markerIdVal);

    final MarkerId markerId = MarkerId(stationName);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: stationName, snippet: description),
      onTap: () {
        cardTitle = description;

      },
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
      // cardTitle = description;
      stationID = stationName;
    });
  }

  Future<void> _graphButton(String parameterCode, String station)  async {


    setState(()  {
      dataURL = "https://waterservices.usgs.gov/nwis/dv/?format=json&indent=on&sites=" +
          station +
          "&period=P90D&parameterCd=" +
          parameterCode +
          "&siteStatus=active";
    });
    // print("data URL: " + dataURL);

    //parseurl
    String dataJson = await parseURL(dataURL);
    values = await getStreamFlowData(dataJson);
    // print("post graph button values");
    // print(values);

  }

  Future<String> parseURL(String sitesURL) async {
    //markers to place on map
    String streamFlowString =
    await http.read(Uri.parse(sitesURL)); //TODO set up REST service url
    return streamFlowString;
  }

  Future<List<FlSpot>> getStreamFlowData(String sitesURL) async {
    //markers to place on map

    final String response = editDataUrlXML(sitesURL);

    // List<FlSpot> values = [];
    var data = json.decode(response);

    var jsonLength = data['value'].length;

     _addData(data, jsonLength);

    return values;
  }

  void _addData(var data, var jsonLength) {
    // loops through json to add all marker data
    for (int i = 0; i < jsonLength; i++) {
      double measurement = double.parse(data['value'][i]['value']);

      values.add(FlSpot(i.toDouble(), measurement));
      // print("values: " + measurement.toString() + ", " + i.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('USGS Monitoring Stations'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(children: <Widget>[
          GoogleMap(
            mapType: MapType.satellite, //map type

            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            onCameraMove: _onGeoChanged,
            markers: Set<Marker>.of(markers.values),
          ),
          DraggableScrollableSheet(
            initialChildSize:
                cardHeight, //i set this smaller, how does it look?
            minChildSize: 0.1,
            snap: true,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: CustomScrollViewContent(cardTitle, _graphButton, stationID, values),
              );
            },
          ),
        ]),
      ),
    );
  }
}
