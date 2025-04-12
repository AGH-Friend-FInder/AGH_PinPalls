import 'package:agh_pin_palls/screens/map/map_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

enum SampleItem { live, pin }

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _YourMarker {
  final GeoPoint geoPoint;

  _YourMarker({required this.geoPoint});
}

class _MapScreenState extends State<MapScreen> {
  int _counter = 0;
  _YourMarker? _yourMarker;

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

  final List<String> _tags = [
    "Friends",
    "Public",
    "Informatyka",
    "Coin",
    "Cyberka",
    "Algo",
    "WO",
  ];

  // Lista przechowująca zaznaczone tagi
  final List<String> _selectedTags = [];

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

        if (_yourMarker == null) {
          _controller.addMarker(
            geoPoint,
            markerIcon: const MarkerIcon(
              icon: Icon(Icons.person, color: Colors.red, size: 48),
            ),
          );
        } else {
          _controller.changeLocationMarker(
            oldLocation: _yourMarker!.geoPoint,
            newLocation: geoPoint,
          );
        }

        _yourMarker = _YourMarker(geoPoint: geoPoint);

        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Text('${geoPoint.latitude}'),
                    //     Text('${geoPoint.longitude}')
                    //   ],),
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
                        Text('$_counter', style: const TextStyle(fontSize: 24)),
                        const SizedBox(width: 20),
                        // Przycisk zwiększania
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _increment,
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children:
                          _tags.map((tag) {
                            // Sprawdzamy czy tag jest zaznaczony
                            final isSelected = _selectedTags.contains(tag);

                            return ChoiceChip(
                              label: Text(tag),
                              selected: isSelected,
                              onSelected: (bool value) {
                                setState(() {
                                  if (value) {
                                    // Dodajemy tag do zaznaczonych
                                    _selectedTags.add(tag);
                                  } else {
                                    // Usuwamy tag z zaznaczonych
                                    _selectedTags.remove(tag);
                                  }
                                });
                              },
                              // Możesz dostosować wygląd:
                              selectedColor: Colors.blue.shade300,
                              disabledColor: Colors.grey.shade200,
                              labelStyle: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black87,
                              ),
                            );
                          }).toList(),
                    ),
                    ElevatedButton(
                      child: const Text('Zatwierdź'),
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
