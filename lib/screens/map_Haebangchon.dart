import 'package:flutter/material.dart';
import 'package:nunsong/services/api_service.dart';
import 'package:nunsong/services/map_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map_Haebangchon extends StatefulWidget {
  const Map_Haebangchon({super.key});

  @override
  State<Map_Haebangchon> createState() => _Map_HaebangchonState();
}

class _Map_HaebangchonState extends State<Map_Haebangchon> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
