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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    try {
      // Add your Firebase Firestore code here to save the shop
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Shop added successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding shop: $e')),
      );
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
              Text("Location : $_selectedLocation"),
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
