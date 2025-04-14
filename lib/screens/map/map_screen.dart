import 'dart:async';

import 'package:agh_pin_palls/screens/map/map_menu_bar.dart';
import 'package:agh_pin_palls/screens/map/map_modal_new.dart';
import 'package:agh_pin_palls/screens/map/map_tag.dart';
import 'package:agh_pin_palls/screens/map/map_modal_marker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:provider/provider.dart';

import '../../models/group.dart';
import '../../provider.dart';

final GeoPoint startPosition = GeoPoint(
  latitude: 50.068771,
  longitude: 19.905344,
);

final BoundingBox areaBox = BoundingBox(
  north: 50.06954,
  east: 19.92448,
  south: 50.06326,
  west: 19.90174,
);

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with OSMMixinObserver {
  final MapTagState _yourMarker = MapTagState();
  final Map<GeoPoint, MapTagState> _mapMarkers = {};

  final MapController _controller = MapController(initPosition: startPosition);

  // final List<MapTagState> _othersGroupMarkers = [];

  // void addNewMarker() {
  //
  // }

  Future<void> selectCurrentLocation() async {
    await _controller.currentLocation();
    GeoPoint? currentLocation = await _controller.myLocation();

    onSingleTap(currentLocation);
  }

  @override
  Widget build(BuildContext context) {
    return MapMenuBar(
      onCurrentLocationPressed: selectCurrentLocation,
      child: OSMFlutter(
        onGeoPointClicked: onMarkerClicked,
        controller: _controller,
        osmOption: OSMOption(
          zoomOption: const ZoomOption(
            initZoom: 18,
            minZoomLevel: 3,
            maxZoomLevel: 19,
          ),
          enableRotationByGesture: true,
          // showDefaultInfoWindow: true,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addObserver(this);
    _controller.changeTileLayer(
      tileLayer: CustomTile.publicTransportationOSM(
        minZoomLevel: 3,
        maxZoomLevel: 20,
      ),
    );
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    _controller.rotateMapCamera(-15);
    _controller.limitAreaMap(areaBox);

    Timer.periodic(const Duration(seconds: 10), (timer) async {
      debugPrint("Fetching pins...");

      await Provider.of<PinProvider>(context, listen: false).fetchVisiblePins(
        Provider.of<UserProvider>(context, listen: false).user!.id,
      );

      if (!mounted) return;

      await Provider.of<GroupProvider>(
        context,
        listen: false,
      ).fetchGroupsFromUserId(
        Provider.of<UserProvider>(context, listen: false).user!.id,
      );

      Map<int, Group> groups = {};

      if (!mounted) return;
      Provider.of<GroupProvider>(context, listen: false).userGroups.forEach((
        group,
      ) {
        groups[group.id] = group;
      });

      Set<GeoPoint> markersSet = _mapMarkers.keys.toSet();

      for (var pin in Provider.of<PinProvider>(context, listen: false).pins) {
        GeoPoint location = GeoPoint(
          latitude: pin.latitude,
          longitude: pin.longitude,
        );

        if (markersSet.contains(location)) {
          markersSet.remove(location);

          _mapMarkers[location]!.peopleCounter = pin.numberOfPeople;
          _mapMarkers[location]!.time = pin.expireAtMinutes;
        } else {
          _mapMarkers[location] = MapTagState(
            position: location,
            peopleCounter: pin.numberOfPeople,
            time: pin.expireAtMinutes,
          );

          _mapMarkers[location]!.selectedTags =
              pin.groupsId.map((pin) {
                return groups[pin]!;
              }).toList();

          _controller.addMarker(
            location,
            markerIcon: MarkerIcon(
              icon: const Icon(
                Icons.people_alt,
                color: Colors.orange,
                size: 48,
              ),
            ),
          );
        }

        for (var location in markersSet) {
          _controller.removeMarker(location);
          _mapMarkers.remove(location);
        }
      }
    });
  }

  void onMarkerClicked(GeoPoint geoPoint) async {
    if (geoPoint == _yourMarker.position) {
      showMarkerInfo(context, _yourMarker);
      return;
    } else {
      showMarkerInfo(context, _mapMarkers[geoPoint]!);
    }
  }

  @override
  void onSingleTap(GeoPoint position) async {
    super.onSingleTap(position);
    if (!areaBox.inBoundingBox(position)) return;

    _controller.addMarker(
      position,
      markerIcon: const MarkerIcon(
        icon: Icon(Icons.location_on, color: Colors.blue, size: 48),
      ),
    );

    if (!await showMapBottomModal(context, MapTagState(position: position))) {
      _controller.removeMarker(position);
      return;
    }

    _controller.changeLocationMarker(
      oldLocation: position,
      newLocation: position,
      markerIcon: const MarkerIcon(
        icon: Icon(Icons.person, color: Colors.red, size: 48),
      ),
    );

    if (_yourMarker.position != null) {
      _controller.removeMarker(_yourMarker.position!);
    }

    _yourMarker.position = position;
  }
}
