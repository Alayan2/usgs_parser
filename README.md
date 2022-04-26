# usgs_parser

A Flutter project that uses USGS REST Web Services, Google Maps, and Flutter_Charts.

## Getting Started

This application opens to a map provided by the Google Maps API. As the user scrolls around the map and zooms, the app generates a URL query to the
USGS REST Service site based on the central coordinates (Figure 1). 
 
   <img width="464" alt="image" src="https://user-images.githubusercontent.com/90277439/165370537-fa770832-0866-408a-b2cb-0643e777dbc5.png">

   Figure 1 Example URL of REST Web Service query for stations

If stations exist within the range of the map in frame, the site returns a JSON file that is parsed for station markers that are then added to the map. URL
queries are only generated if the zoom level of the map is 11 or greater. 
Once the stations are populated, the user can click on the station marker. When the station marker is clicked, the title of an elevated card at the bottom 
of the screen is updated with that text. The user can then drag the card up and click a button for flow or gage height data. When the user clicks either 
button, another URL query is generated for the desired data from a period of 90 days prior to the current date (Figure 2). The USGS site returns a JSON 
file which is parsed by the application to generate a list which is then plotted to the graph.  
 
   <img width="448" alt="image" src="https://user-images.githubusercontent.com/90277439/165370584-443ef7d0-b9af-453d-b8c4-258a4d9ec947.png">

   Figure 2 Example URL of REST Web Service query for flow data


The application works as described but requires some work before publishing to the Google Play Store and Apple App Store. Currently there are no status 
indicators on the app that communicate to the user if an action has triggered a response that is loading. There should also be some indicator of when the 
user has zoomed to a sufficient level to trigger a query. 


## USGS Monitoring Data App Storyboard
 
 <img width="458" alt="image" src="https://user-images.githubusercontent.com/90277439/165371032-074fd99e-cacd-40e8-9f1f-0da72ae058bd.png">

