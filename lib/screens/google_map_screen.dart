import 'dart:math';

import 'package:flavor_fiesta/core/entities/e_shop.dart';
import 'package:flavor_fiesta/core/res/sampledata/app_data.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Location location = Location();
  final List<Shop> shops = shopData;
  LatLng? currentPosition;
  bool showNearest = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await fetchLocationUpdates());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(title: 'Nearest Flavor Fiesta'),
        body: currentPosition == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(children: [
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: currentPosition!, zoom: 13),
                  markers: {
                    Marker(
                        markerId: const MarkerId('currentLocation'),
                        icon: BitmapDescriptor.defaultMarker,
                        position: currentPosition!,
                        infoWindow: const InfoWindow(title: 'Your Location')),
                    ...getShopsToDisplay().map((shop) => Marker(
                        markerId: MarkerId(shop.location),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueBlue),
                        position: shop.mapLocation,
                        infoWindow: InfoWindow(title: shop.location)))
                  },
                ),
                Positioned(
                    bottom: 10,
                    left: 10,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showNearest = !showNearest;
                        });
                      },
                      style: AppStyles.darkButton,
                      child: Text(
                          showNearest ? 'View All Shops' : 'View Nearest Shops',
                          style: AppStyles.headLineStyle3
                              .copyWith(color: AppStyles.paletteLight)),
                    )),
              ]));
  }

  Future<void> fetchLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await location.requestService();
    } else {
      return;
    }

    permissionGranted = await location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          currentPosition = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );
        });
      }
    });
  }

  List<Shop> getShopsToDisplay() {
    if (currentPosition == null) {
      return [];
    }
    if (showNearest) {
      return getNearestShops();
    } else {
      return shops;
    }
  }

  List<Shop> getNearestShops() {
    shops.sort((a, b) => _calculateDistance(currentPosition!, a.mapLocation)
        .compareTo(_calculateDistance(currentPosition!, b.mapLocation)));

    return shops.take(5).toList();
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371000; // meters
    final double dLat = _degreesToRadians(end.latitude - start.latitude);
    final double dLng = _degreesToRadians(end.longitude - start.longitude);
    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(start.latitude)) *
            cos(_degreesToRadians(end.latitude)) *
            sin(dLng / 2) *
            sin(dLng / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
