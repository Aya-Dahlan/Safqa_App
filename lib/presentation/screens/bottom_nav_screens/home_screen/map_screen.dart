import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safqa_app/presentation/widgets/custom_button_widget.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(24.7136, 46.6753); // موقع الرياض

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home filter'),
        leading: IconButton(
          icon: const Icon(Icons.code),
          onPressed: () {}, // يمكنك وضع حدث عند الضغط
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 10.0,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: CustomButton(onTap: () {}, title: 'حفظ'),
          ),
        ],
      ),
    );
  }
}
