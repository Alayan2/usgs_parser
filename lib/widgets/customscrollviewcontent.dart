import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'custominnercontent.dart';

/// Content of the DraggableBottomSheet's child SingleChildScrollView
class CustomScrollViewContent extends StatelessWidget {

  final String titleText;
  final Function(String a, String b) graphButton;
  final String station;
  final List<FlSpot> values;

  const CustomScrollViewContent(this.titleText, this.graphButton, this.station, this.values);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),

          child:CustomInnerContent(titleText, graphButton, station, values),
      ),
      );
  }
}