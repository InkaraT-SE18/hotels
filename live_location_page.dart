import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LiveLocationPage extends StatefulWidget {
  const LiveLocationPage({super.key});

  @override
  State<LiveLocationPage> createState() => _LiveLocationPageState();
}

class _LiveLocationPageState extends State<LiveLocationPage> {
  final MapController _mapController = MapController();

  final LatLng userLocation = LatLng(51.1280, 71.4300); 
  double _currentZoom = 16;

  final List<Marker> _customMarkers = [];

  void _zoomIn() {
    setState(() {
      _currentZoom += 1;
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom -= 1;
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _addMarker(LatLng point) {
    setState(() {
      _customMarkers.add(
        Marker(
          point: point,
          width: 40,
          height: 40,
          child: GestureDetector(
            onTap: () => _removeMarker(point),
            child: const Icon(Icons.location_on, color: Colors.red, size: 40),
          ),
        ),
      );
    });
  }

  void _removeMarker(LatLng point) {
    setState(() {
      _customMarkers.removeWhere((marker) => marker.point == point);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location')),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: userLocation,
              initialZoom: _currentZoom,
              interactionOptions: const InteractionOptions(flags: InteractiveFlag.all),
              onTap: (_, point) => _addMarker(point),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.booking_hotels',
              ),
              MarkerLayer(
                markers: [
                 
                  Marker(
                    point: userLocation,
                    width: 60,
                    height: 60,
                    child: const Icon(Icons.my_location, size: 50, color: Colors.blue),
                  ),
                  ..._customMarkers,
                ],
              ),
            ],
          ),

          Positioned(
            top: 10,
            right: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'zoomIn',
                  mini: true,
                  onPressed: _zoomIn,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'zoomOut',
                  mini: true,
                  onPressed: _zoomOut,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
