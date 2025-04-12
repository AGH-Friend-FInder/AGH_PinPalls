import 'package:agh_pin_palls/screens/map/map_menu_bar.dart';
import 'package:agh_pin_palls/screens/map/map_modal_new.dart';
import 'package:agh_pin_palls/screens/map/map_tag.dart';
import 'package:agh_pin_palls/screens/map/map_modal_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

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

  final MapController _controller = MapController(initPosition: startPosition);

  @override
  Widget build(BuildContext context) {
    return MapMenuBar(
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
          showDefaultInfoWindow: true,
          // userTrackingOption: UserTrackingOption(
          //     enableTracking: true
          // )
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

    // GeoPoint centerPoint = GeoPoint(
    //   latitude: (areaBox.north + areaBox.south) / 2,
    //   longitude: (areaBox.east + areaBox.west) / 2,
    // );

    //_controller.drawRect(RectOSM(key: "abc", centerPoint: centerPoint, distance: 20, color: Colors.red, strokeWidth: 2));
  }

  void onMarkerClicked(GeoPoint geoPoint) async {
    debugPrint("Clicked on: ${geoPoint.latitude}, ${geoPoint.longitude}");
    showMarkerInfo(context, _yourMarker);
  }

  @override
  void onSingleTap(GeoPoint position) async {
    super.onSingleTap(position);

    if (!areaBox.inBoundingBox(position)) return;
    if (!await showMapBottomModal(context, _yourMarker)) return;

    if (_yourMarker.position == null) {
      _controller.addMarker(
        position,
        markerIcon: const MarkerIcon(
          icon: Icon(Icons.person, color: Colors.red, size: 48),
        ),
      );

      _yourMarker.position = position;
    } else {
      _controller.changeLocationMarker(
        oldLocation: _yourMarker.position!,
        newLocation: position,
      );

      _yourMarker.position = position;
    }
  }
}
