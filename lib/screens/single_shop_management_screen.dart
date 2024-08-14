import 'package:flavor_fiesta/core/entities/e_shop.dart';
import 'package:flavor_fiesta/core/helpers/helper_functions.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SingleShopManagementScreen extends StatefulWidget {
  final Map<String, dynamic> shopData;
  final String shopId;
  const SingleShopManagementScreen(
      {super.key, required this.shopData, required this.shopId});

  @override
  State<SingleShopManagementScreen> createState() =>
      _SingleShopManagementScreenState();
}

class _SingleShopManagementScreenState
    extends State<SingleShopManagementScreen> {
  String? _selectedFoodId;
  Map<String, String> _foodMap = {}; // Maps foodId to foodName
  Map<String, String> _availableFoodMap =
      {}; // Maps foodId to foodName for available items
  late Shop shop;

  @override
  void initState() {
    super.initState();
    _initializeShop();
    _fetchAvailableFoods();
  }

  void _initializeShop() {
    shop = Shop(
      shopId: widget.shopId,
      location: widget.shopData['location'] ?? 'Unknown location',
      // mapLocation: const LatLng(0, 0),
      mapLocation: widget.shopData['mapLocation'] != null
          ? LatLng(
              widget.shopData['mapLocation']["latitude"],
              widget.shopData['mapLocation']["longitude"],
            )
          : const LatLng(0, 0),
      availableItems:
          List<String>.from(widget.shopData['availableItems'] ?? []),
    );
  }

  Future<void> _fetchAvailableFoods() async {
    try {
      final QuerySnapshot foodSnapshot =
          await FirebaseFirestore.instance.collection('Foods').get();

      setState(() {
        _foodMap = {
          for (var doc in foodSnapshot.docs)
            doc.id: doc['name'] ?? 'Unknown Food'
        };
        // Create a map of only the available items to their names
        _availableFoodMap = {
          for (var item in shop.availableItems)
            item: _foodMap[item] ?? 'Unknown Food'
        };
      });
    } catch (e) {
      displayMessageToUser('Error fetching foods: $e', context);
    }
  }

  Future<void> _addFoodToShop() async {
    if (_selectedFoodId == null || _selectedFoodId!.isEmpty) {
      displayMessageToUser('Please select a food', context);
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('Shops')
          .doc(widget.shopId)
          .update({
        'availableItems': FieldValue.arrayUnion([_selectedFoodId])
      });

      setState(() {
        shop.availableItems.add(_selectedFoodId!);
        _availableFoodMap[_selectedFoodId!] = _foodMap[_selectedFoodId!]!;
        _selectedFoodId = null; // Reset the dropdown selection after adding
      });
    } catch (e) {
      displayMessageToUser('Food adding Failed: $e', context);
    }
  }

  Future<void> _removeFoodFromShop(String foodId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Shops')
          .doc(widget.shopId)
          .update({
        'availableItems': FieldValue.arrayRemove([foodId])
      });

      setState(() {
        shop.availableItems.remove(foodId);
        _availableFoodMap.remove(foodId);
      });
    } catch (e) {
      displayMessageToUser('Food removal failed: $e', context);
    }
  }

  Future<void> _deleteShop() async {
    try {
      await FirebaseFirestore.instance
          .collection('Shops')
          .doc(widget.shopId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Shop deleted')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting shop: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter the items to exclude already added items
    final dropdownItems = _foodMap.entries
        .where((entry) => !shop.availableItems.contains(entry.key))
        .map((entry) {
      return DropdownMenuItem<String>(
        value: entry.key,
        child: Text(entry.value),
      );
    }).toList();

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Manage Shop: ${shop.location}',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location: ${shop.location}',
              style: AppStyles.headLineStyle1,
            ),
            const SizedBox(height: 10),
            Text(
              'Available Items:',
              style: AppStyles.headLineStyle2,
            ),
            const SizedBox(height: 10),
            ..._availableFoodMap.entries.map((entry) {
              return Row(
                children: [
                  Expanded(child: Text('${entry.value}')),
                  IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () => _removeFoodFromShop(entry.key),
                  ),
                ],
              );
            }).toList(),
            const SizedBox(height: 20),
            DropdownButton<String>(
              hint: const Text('Select Food to Add'),
              value: _selectedFoodId,
              items: dropdownItems,
              onChanged: (newValue) {
                setState(() {
                  _selectedFoodId = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _addFoodToShop,
                  style: AppStyles.darkButton,
                  child: const Text('Add Food'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _deleteShop,
                  style: AppStyles.redButton,
                  child: const Text('Delete Shop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

