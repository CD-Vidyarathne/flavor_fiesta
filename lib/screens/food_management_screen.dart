import 'package:flavor_fiesta/core/entities/e_food.dart';
import 'package:flavor_fiesta/core/helpers/helper_functions.dart';
import 'package:flavor_fiesta/core/res/routes/app_routes.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';

class FoodManagementScreen extends StatefulWidget {
  const FoodManagementScreen({super.key});

  @override
  State<FoodManagementScreen> createState() => _FoodManagementScreenState();
}

class _FoodManagementScreenState extends State<FoodManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Food> _foods = [];
  final List<Food> _filteredFoods = [];

  @override
  void initState() {
    super.initState();
    _loadFoods();
  }

  void _loadFoods() async {
    final foods = await FirebaseFirestore.instance.collection('Foods').get();
    setState(() {
      _foods.clear();
      _filteredFoods.clear();
      for (var doc in foods.docs) {
        final foodData = doc.data();
        _foods.add(Food(
          foodId: doc.id,
          name: foodData['name'],
          availableSizes: List<String>.from(foodData['availableSizes']),
          availableToppings: List<String>.from(foodData['availableToppings']),
          price: foodData['price'].toDouble(),
          priceInForMd: foodData['priceInForMd']?.toDouble() ?? 0,
          priceInForLg: foodData['priceInForLg']?.toDouble() ?? 0,
        ));
      }
      _filteredFoods.addAll(_foods);
    });
  }

  void _filterFoods(String query) {
    setState(() {
      _filteredFoods.clear();
      if (query.isEmpty) {
        _filteredFoods.addAll(_foods);
      } else {
        _filteredFoods.addAll(_foods.where(
            (food) => food.name.toLowerCase().contains(query.toLowerCase())));
      }
    });
  }

  void _deleteFood(String foodId) async {
    try {
      await FirebaseFirestore.instance.collection('Foods').doc(foodId).delete();
      displayMessageToUser("Food deleted successfully.", context);
      _loadFoods();
    } catch (e) {
      displayMessageToUser("Error deleting food.", context);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Food Management',
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.addNewFood);
              },
              style: AppStyles.darkButton,
              child: const Text('Add New Food'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Food',
                border: OutlineInputBorder(),
              ),
              onChanged: _filterFoods,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredFoods.length,
                itemBuilder: (context, index) {
                  final food = _filteredFoods[index];
                  return ListTile(
                    title: Text(food.name),
                    subtitle: Text('Price: Rs.${food.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteFood(food.foodId),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
