import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMapPage extends StatelessWidget {
  OpenStreetMapPage({super.key});

  final List<Marker> _markers = [
    Marker(
      point: LatLng(40.4193, -3.6933),
      width: 40,
      height: 40,
      child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
    ),
    Marker(
      point: LatLng(40.38495, -3.71852), 
      width: 40,
      height: 40,
      child: const Icon(Icons.restaurant, color: Colors.blue, size: 40),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mapa de Madrid")),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(40.4183, -3.6919), // Madrid
          initialZoom: 14.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(markers: _markers),
        ],
      ),
    );
  }
}