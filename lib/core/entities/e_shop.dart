import 'package:google_maps_flutter/google_maps_flutter.dart';

class Shop {
  String shopId;
  final String location;
  final LatLng mapLocation;
  List<String> availableItems = [];

  Shop({
    this.shopId = "0000",
    required this.location,
    required this.mapLocation,
    List<String>? availableItems,
  }) : availableItems = availableItems ?? [];
}
