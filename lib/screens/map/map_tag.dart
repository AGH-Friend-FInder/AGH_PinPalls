import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapTagState {
  GeoPoint? position;
  List<String> selectedTags = [];
  int counter = 0;

  void incrementCounter() {
    counter++;
  }

  void decrementCounter() {
    if (counter > 0) {
      counter--;
    }
  }
}
