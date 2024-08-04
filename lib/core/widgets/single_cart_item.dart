import 'package:flavor_fiesta/core/entities/e_order_food_item.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flutter/material.dart';

class SingleCartItem extends StatefulWidget {
  final OrderFoodItem orderFoodItem;
  final Function(OrderFoodItem) onRemove;
  final Function(OrderFoodItem, int) onQuantityChange;

  const SingleCartItem({
    super.key,
    required this.orderFoodItem,
    required this.onRemove,
    required this.onQuantityChange,
  });

  @override
  _SingleCartItemState createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.orderFoodItem.quantity;
  }

  void updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
      widget.onQuantityChange(widget.orderFoodItem, quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppStyles.paletteDark, width: 1.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.orderFoodItem.food.name,
                style: AppStyles.textBlackStyle1,
              ),
              IconButton(
                onPressed: () => widget.onRemove(widget.orderFoodItem),
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            'Size: ${widget.orderFoodItem.selectedSize}',
            style: AppStyles.textBlackStyle2,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Toppings: ${widget.orderFoodItem.selectedToppings.join(', ')}',
            style: AppStyles.textBlackStyle2,
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quantity:',
                style: AppStyles.textBlackStyle2,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (quantity > 1) {
                        updateQuantity(quantity - 1);
                      }
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    quantity.toString(),
                    style: AppStyles.textBlackStyle1,
                  ),
                  IconButton(
                    onPressed: () {
                      updateQuantity(quantity + 1);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            'Total Price: ${OrderFoodItem.calculatePrice(widget.orderFoodItem.food, widget.orderFoodItem.selectedSize, widget.orderFoodItem.selectedToppings, quantity).toStringAsFixed(2)}',
            style: AppStyles.textBlackStyle2,
          ),
        ],
      ),
    );
  }
}
