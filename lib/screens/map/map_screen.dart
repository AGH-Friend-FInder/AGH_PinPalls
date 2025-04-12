import 'package:agh_pin_palls/items/map_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

enum SampleItem { live, pin }

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      _counter--;
    });
  }

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

    _controller.listenerMapSingleTapping.addListener(() {
      if (_controller.listenerMapSingleTapping.value != null) {
        GeoPoint geoPoint = _controller.listenerMapSingleTapping.value!;
        _controller.addMarker(
          geoPoint,
          markerIcon: const MarkerIcon(
            icon: Icon(Icons.person, color: Colors.red, size: 48),
          )
        );
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 350,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${geoPoint.latitude}'),
                          Text('${geoPoint.longitude}')
                        ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Przycisk zmniejszania
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: _decrement,
                          ),
                          // Odstęp między przyciskami
                          const SizedBox(width: 20),
                          // Wyświetlanie aktualnego stanu licznika
                          Text(
                            '$_counter',
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 20),
                          // Przycisk zwiększania
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: _increment,
                          ),
                        ],
                      ),
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MapMenuBar(
      child: OSMFlutter(
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
}