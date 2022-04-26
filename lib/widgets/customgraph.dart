import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:usgs_parser/widgets/timeserieschart.dart';
import 'package:xml2json/xml2json.dart';

class CustomGraph extends StatelessWidget {

  final List<FlSpot> values;

  const CustomGraph(this.values);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16),
        child: LineChartSample2(values)

            );
  }
}


//TODO: pull flow and gage data from USGS




String editDataUrlXML(String xmlString) {
  String alteredString = "";

  //indices for extracting coordinates
  const start = '"values" : [ {';
  const end = '"qualifier" : [ {';

  final startIndex =
      xmlString.indexOf(start); //startIndex for extracting coordinates
  final endIndex = xmlString.indexOf(
      end, startIndex + start.length); //endIndex for extracting coordinates

  String jsonString = xmlString.substring(startIndex + start.length, endIndex-8);

  alteredString = "{" + jsonString  + "\n   }";

  // print("altered string: " + alteredString.substring(10400, alteredString.length));

  return alteredString;
}

class Values {
  String value;
  String dateTime;
  Values(this.value, this.dateTime);
  factory Values.fromJson(dynamic json) {
    return Values(json['value'], json['dateTime']);
  }
  @override
  String toString() {
    return '{ ${this.value}, ${this.dateTime} }';
  }
}


void minX(){

}

void maxX(){

}

void minY(){

}

void maxY(){

}

// //TODO: add ramp info from https://geodata.myfwc.com/datasets/fwc-florida-boat-ramp-inventory/api
// ///splits coordinates fro place mark string
// String getMeasurements(var data, int i) {
//   //indices for extracting coordinates
//   const start = "coordinates: ";
//   const end = "}, styleUrl";
//
//   print("--------------pre-measurement attempt------------");
//   String measurements = data['timeseries']['values'][i]
//       .toString(); //string on each place mark's data
//   print("measurement i: " + measurements);
//   final startIndex =
//   measurements.indexOf(start); //startIndex for extracting coordinates
//   final endIndex = measurements.indexOf(
//       end, startIndex + start.length); //endIndex for extracting coordinates
//
//   String coordinates =
//   measurements.substring(startIndex + start.length, endIndex);
//
//   // print(coordinates);
//
//   return coordinates;
// }