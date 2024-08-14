import 'package:flavor_fiesta/core/helpers/helper_functions.dart';
import 'package:flavor_fiesta/core/res/routes/app_routes.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';

class AddNewFoodScreen extends StatefulWidget {
  const AddNewFoodScreen({super.key});

  @override
  State<AddNewFoodScreen> createState() => _AddNewFoodScreenState();
}

class _AddNewFoodScreenState extends State<AddNewFoodScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _priceInForMdController = TextEditingController();
  final TextEditingController _priceInForLgController = TextEditingController();
  final List<String> _availableSizes = [];
  final List<TextEditingController> _toppingControllers = [
    TextEditingController()
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _priceInForMdController.dispose();
    _priceInForLgController.dispose();
    for (var controller in _toppingControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _saveFood() async {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _availableSizes.isEmpty ||
        _toppingControllers[0].text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    List<String> availableToppings = _toppingControllers
        .where((controller) => controller.text.isNotEmpty)
        .map((controller) => controller.text)
        .toList();

    try {
      await FirebaseFirestore.instance.collection('Foods').add({
        'name': _nameController.text,
        'availableSizes': _availableSizes,
        'availableToppings': availableToppings,
        'price': double.parse(_priceController.text),
        'priceInForMd': double.tryParse(_priceInForMdController.text) ?? 0,
        'priceInForLg': double.tryParse(_priceInForLgController.text) ?? 0,
      });
      Navigator.pushNamed(context, AppRoutes.authenticated);
      displayMessageToUser('Food added successfully', context);
    } catch (e) {
      displayMessageToUser('Error adding Food $e', context);
    }
  }

  void _toggleSize(String size) {
    setState(() {
      if (_availableSizes.contains(size)) {
        _availableSizes.remove(size);
      } else {
        _availableSizes.add(size);
      }
    });
  }

  void _addToppingField() {
    if (_toppingControllers.length < 5) {
      setState(() {
        _toppingControllers.add(TextEditingController());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Add New Food',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Food Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _priceInForMdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Price Increment for Medium Size'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _priceInForLgController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Price Increment for Large Size'),
              ),
              const SizedBox(height: 10),
              const Text('Available Sizes:'),
              CheckboxListTile(
                title: const Text('Small'),
                value: _availableSizes.contains('Small'),
                onChanged: (value) => _toggleSize('Small'),
              ),
              CheckboxListTile(
                title: const Text('Medium'),
                value: _availableSizes.contains('Medium'),
                onChanged: (value) => _toggleSize('Medium'),
              ),
              CheckboxListTile(
                title: const Text('Large'),
                value: _availableSizes.contains('Large'),
                onChanged: (value) => _toggleSize('Large'),
              ),
              const SizedBox(height: 10),
              const Text('Available Toppings:'),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _toppingControllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TextField(
                      controller: _toppingControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Topping ${index + 1}',
                        suffixIcon:
                            _toppingControllers.length - 1 == index && index < 4
                                ? IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: _addToppingField,
                                  )
                                : null,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty &&
                            _toppingControllers.length - 1 == index &&
                            index < 4) {
                          _addToppingField();
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveFood,
                  style: AppStyles.darkButton,
                  child: const Text('Save Food'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
