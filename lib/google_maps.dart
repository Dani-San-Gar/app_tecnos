import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({super.key});

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  late GoogleMapController mapController;

  final LatLng cibeles = const LatLng(40.4195, -3.6938);
  final LatLng aparicio = const LatLng(40.4381, -3.7017);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Madrid'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: cibeles,
          zoom: 14.0,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('cibeles'),
            position: cibeles,
            infoWindow: const InfoWindow(title: 'Fuente de Cibeles'),
          ),
          Marker(
            markerId: const MarkerId('aparicio'),
            position: aparicio,
            infoWindow: const InfoWindow(title: 'Restaurante Aparicio'),
          ),
        },
      ),
    );
  }
} 