import 'package:flavor_fiesta/core/entities/e_order_food_item.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flutter/material.dart';

class ViewCartScreen extends StatelessWidget {
  final List<OrderFoodItem> cartItems;
  const ViewCartScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Your cart is empty.'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(
                    item.food.name,
                    style: AppStyles.textBlackStyle1,
                  ),
                  subtitle: Text(
                    'Size: ${item.selectedSize}, Toppings: ${item.selectedToppings.join(', ')}, Quantity: ${item.quantity}',
                    style: AppStyles.textBlackStyle2,
                  ),
                  trailing: Text(
                    'Rs.${item.price.toStringAsFixed(2)}',
                    style: AppStyles.textBlackStyle1,
                  ),
                );
              },
            ),
    );
  }
}
