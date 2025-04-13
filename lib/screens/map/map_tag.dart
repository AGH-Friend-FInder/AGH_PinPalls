import 'package:agh_pin_palls/models/group.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapTagState {
  GeoPoint? position;
  List<Group> selectedTags = [];
  int peopleCounter = 0;
  int time = 30;

  MapTagState({this.position, this.peopleCounter = 0, this.time = 30});

  void incrementPeopleCount() {
    peopleCounter++;
  }

  void decrementPeopleCount() {
    if (peopleCounter > 0) {
      peopleCounter--;
    }
  }

  void incrementTimer(int val) {
    time = time + val;
  }

  void decrementTimer(int val) {
    if (time + val > 0) {
      time = time + val;
    }
  }
}
