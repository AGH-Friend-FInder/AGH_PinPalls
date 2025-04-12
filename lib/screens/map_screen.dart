import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

enum SampleItem { live, pin }

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _controller = MapController(
    initPosition: GeoPoint(latitude: 50.068771, longitude: 19.905344),
    areaLimit: BoundingBox(
      north: 50.06954,
      east: 19.92448,
      south: 50.06326,
      west: 19.90174,
    ),
  );

  _MapScreenState() {
    _controller.limitAreaMap(
      BoundingBox(
        north: 50.06954,
        east: 19.92448,
        south: 50.06326,
        west: 19.90174,
      ),
    );
    _controller.changeTileLayer(
      tileLayer: CustomTile.publicTransportationOSM(
        minZoomLevel: 3,
        maxZoomLevel: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map Screen')),
      body: OSMFlutter(
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
      floatingActionButton: MenuAnchor(
        builder: (
            BuildContext context,
            MenuController controller,
            Widget? child,
            ) {
          return FloatingActionButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            tooltip: 'Show menu',
            child: const Icon(Icons.add),
          );
        },
        menuChildren: List<MenuItemButton>.generate(
          3,
              (int index) => MenuItemButton(
            onPressed:
                () => (/*TODO: store the selected item*/),
            child: Text('Item ${index + 1}'),
          ),
        ),
      ),
    );
  }
}
