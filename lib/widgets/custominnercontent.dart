import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:usgs_parser/widgets/dataButton.dart';
import 'package:usgs_parser/widgets/timeserieschart.dart';

import 'customgraph.dart';

class CustomInnerContent extends StatelessWidget {

  final titleText;
  final Function(String a, String b) graphButton;
  final String station;
  final List<FlSpot> values;

  const CustomInnerContent(this.titleText, this.graphButton, this.station, this.values);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 12),
        CustomDraggingHandle(),
        SizedBox(height: 16),
        CustomCardTitle(titleText),
        SizedBox(height: 16),
        dataButton("Get Flow Data", graphButton, "00060", station),
        SizedBox(height: 16),
        CustomGraph(values),
        SizedBox(height: 16),
        dataButton("Get Gage Data", graphButton, "00060", station),
        SizedBox(height: 16),
        CustomGraph(values),
        // CustomHorizontallyScrollingRestaurants(),
        SizedBox(height: 24),
        CustomFeaturedListsText(),
        SizedBox(height: 16),
        CustomFeaturedItemsGrid(),
        SizedBox(height: 24),
        CustomRecentPhotosText(),
        SizedBox(height: 16),
        CustomRecentPhotoLarge(),
        SizedBox(height: 12),
        CustomRecentPhotosSmall(),
        SizedBox(height: 16),
      ],
    );
  }
}

class CustomDraggingHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 30,
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
    );
  }
}


class CustomCardTitle extends StatelessWidget {

  final titleText;

  const CustomCardTitle(this.titleText);


  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(child: Text(titleText, style: TextStyle(fontSize: 14, color: Colors.black45))),
        SizedBox(width: 8),
        Container(
          height: 24,
          width: 24,
          child: Icon(Icons.arrow_forward_ios, size: 12, color: Colors.black54),
          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
        ),
      ],
    );
  }
}

class CustomHorizontallyScrollingRestaurants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            CustomRestaurantCategory(),
            SizedBox(width: 12),
            CustomRestaurantCategory(),
            SizedBox(width: 12),
            CustomRestaurantCategory(),
            SizedBox(width: 12),
            CustomRestaurantCategory(),
            SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

class CustomFeaturedListsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      //only to left align the text
      child: Row(
        children: <Widget>[Text("Featured Lists", style: TextStyle(fontSize: 14))],
      ),
    );
  }
}

class CustomFeaturedItemsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        //to avoid scrolling conflict with the dragging sheet
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        shrinkWrap: true,
        children: <Widget>[
          CustomFeaturedItem(),
          CustomFeaturedItem(),
          CustomFeaturedItem(),
          CustomFeaturedItem(),
        ],
      ),
    );
  }
}

class CustomRecentPhotosText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: <Widget>[
          Text("Recent Photos", style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class CustomRecentPhotoLarge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomFeaturedItem(),
    );
  }
}

class CustomRecentPhotosSmall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFeaturedItemsGrid();
  }
}

class CustomRestaurantCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class CustomFeaturedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

