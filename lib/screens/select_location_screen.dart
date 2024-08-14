import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Function(LatLng) onLocationSelected;

  const MapScreen({super.key, required this.onLocationSelected});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(6.9271, 79.861);
  LatLng? _selectedLocation;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  void _confirmLocation() {
    if (_selectedLocation != null) {
      widget.onLocationSelected(_selectedLocation!);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a location')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Select Location',
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 12.0,
            ),
            onTap: _onTap,
            markers: _selectedLocation != null
                ? {
                    Marker(
                      markerId: const MarkerId('selectedLocation'),
                      position: _selectedLocation!,
                    )
                  }
                : {},
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: ElevatedButton(
              onPressed: _confirmLocation,
              style: AppStyles.darkButtonSquare,
              child: const Icon(Icons.check),
            ),
          ),
        ],
      ),
    );
  }
}
