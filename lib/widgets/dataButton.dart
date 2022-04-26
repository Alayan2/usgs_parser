import 'package:flutter/material.dart';
import 'package:usgs_parser/main.dart';

class dataButton extends StatelessWidget {

  final String buttonText;
  final Function(String a, String b) graphButton;
  final String parameterCode;
  final String station;

  const dataButton(this.buttonText, this.graphButton, this.parameterCode, this.station);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => graphButton(parameterCode, station),
        child: Text(buttonText),
        style: ElevatedButton.styleFrom(
          primary: Colors.blueGrey,
          padding: const EdgeInsets.symmetric(
              horizontal: 5, vertical: 5),
    ));
  }
}