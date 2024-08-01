import 'package:flavor_fiesta/core/entities/e_order_food_item.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flutter/material.dart';

class SingleOrderFoodItem extends StatelessWidget {
  final OrderFoodItem item;
  const SingleOrderFoodItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppStyles.paletteDark,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.name, style: AppStyles.textBlackStyle1),
          const SizedBox(height: 10.0),
          Text('Size: ${item.size}', style: AppStyles.textBlackStyle2),
          const SizedBox(height: 10.0),
          Text('Toppings: ${item.toppings.join(', ')}',
              style: AppStyles.textBlackStyle2),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price:',
                  style: AppStyles.textBlackStyle1.copyWith(fontSize: 16)),
              Text(item.price.toStringAsFixed(2),
                  style: AppStyles.textBlackStyle1.copyWith(fontSize: 16)),
            ],
          )
        ],
      ),
    );
  }
}
