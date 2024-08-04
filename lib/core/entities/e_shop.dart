import 'package:google_maps_flutter/google_maps_flutter.dart';

class Shop {
  final String shopId;
  final String location;
  final LatLng mapLocation;
  List<String> availableItems = [];

  Shop({
    required this.shopId,
    required this.location,
    required this.mapLocation,
    List<String>? availableItems,
  }) : availableItems = availableItems ?? [];

  void addFood(String foodId) {
    availableItems.add(foodId);
  }

  void removeFood(String foodId) {
    availableItems.remove(foodId);
  }
}
