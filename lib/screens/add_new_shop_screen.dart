import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_fiesta/core/helpers/helper_functions.dart';
import 'package:flavor_fiesta/core/res/routes/app_routes.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flavor_fiesta/screens/select_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddNewShopScreen extends StatefulWidget {
  const AddNewShopScreen({super.key});

  @override
  State<AddNewShopScreen> createState() => _AddNewShopScreenState();
}

class _AddNewShopScreenState extends State<AddNewShopScreen> {
  final TextEditingController _shopIdController = TextEditingController();
  LatLng? _selectedLocation;

  @override
  void dispose() {
    _shopIdController.dispose();
    super.dispose();
  }

  Future<void> _saveShop() async {
    if (_shopIdController.text.isEmpty || _selectedLocation == null) {
      displayMessageToUser('Please fill all the details.', context);
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('Shops').doc().set({
        'location': _shopIdController.text,
        'mapLocation': {
          'latitude': _selectedLocation!.latitude,
          'longitude': _selectedLocation!.longitude,
        },
        'availableItems': [],
      });
      Navigator.pushNamed(context, AppRoutes.authenticated);
      displayMessageToUser('Shop added successfully', context);
    } catch (e) {
      displayMessageToUser('Error adding shop: $e', context);
    }
  }

  void _selectLocation(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  void _openMap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(
          onLocationSelected: _selectLocation,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Add New Shop'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _shopIdController,
                decoration: InputDecoration(
                    labelText: 'Branch', focusColor: AppStyles.paletteBlack),
              ),
              const SizedBox(height: 10),
              Text(
                  "Location : ${_selectedLocation ?? "Please select a location on map"}"),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _openMap,
                style: AppStyles.lightButton,
                child: const Text('Select Location on Map'),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveShop,
                  style: AppStyles.darkButton,
                  child: const Text('Save Shop'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
