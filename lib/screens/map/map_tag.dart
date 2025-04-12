import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapTagState {
  GeoPoint? position;
  List<String> selectedTags = [];
  int peopleCounter = 0;

  void incrementPeopleCount() {
    peopleCounter++;
  }

  void decrementPeopleCount() {
    if (peopleCounter > 0) {
      peopleCounter--;
    }
  }
}
