import 'package:flavor_fiesta/core/res/routes/app_routes.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flavor_fiesta/screens/single_shop_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopManagementScreen extends StatefulWidget {
  const ShopManagementScreen({super.key});

  @override
  State<ShopManagementScreen> createState() => _ShopManagementScreenState();
}

class _ShopManagementScreenState extends State<ShopManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _shops = [];
  List<DocumentSnapshot> _filteredShops = [];

  @override
  void initState() {
    super.initState();
    _fetchShops();
  }

  Future<void> _fetchShops() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Shops').get();
    setState(() {
      _shops = snapshot.docs;
      _filteredShops = _shops;
    });
  }

  void _filterShops(String query) {
    setState(() {
      _filteredShops = _shops.where((shop) {
        final location = shop['location'].toLowerCase();
        final input = query.toLowerCase();
        return location.contains(input);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppbar(title: "Shop Management", showBackButton: false),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.addNewShop);
            },
            style: AppStyles.darkButton,
            child: const Text('Add New Shop'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterShops,
              decoration: const InputDecoration(
                labelText: 'Search by Location',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _filteredShops.map((shopDoc) {
                  Map<String, dynamic> shopData =
                      shopDoc.data() as Map<String, dynamic>;
                  String shopId = shopDoc.id.toString();
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(shopData['location']),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Navigate to the shop management page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingleShopManagementScreen(
                                  shopData: shopData, shopId: shopId),
                            ),
                          );
                        },
                        style: AppStyles.darkButton,
                        child: const Text('Manage'),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
