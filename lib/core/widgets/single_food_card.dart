import 'package:flavor_fiesta/core/entities/e_food.dart';
import 'package:flavor_fiesta/core/entities/e_order_food_item.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flutter/material.dart';

class SingleFoodCard extends StatefulWidget {
  final Food food;
  final Function(OrderFoodItem) addToCart;

  const SingleFoodCard({
    super.key,
    required this.food,
    required this.addToCart,
  });

  @override
  _SingleFoodCardState createState() => _SingleFoodCardState();
}

class _SingleFoodCardState extends State<SingleFoodCard> {
  String selectedSize = 'Small';
  List<String> selectedToppings = [];
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 5.0,
      child: Container(
        width: size.width,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.food.name,
              style: AppStyles.textBlackStyle1,
            ),
            const SizedBox(height: 10.0),
            Text(
              'Price: ${OrderFoodItem.calculatePrice(widget.food, selectedSize, selectedToppings, quantity)}',
              style: AppStyles.textBlackStyle2,
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Size:'),
                DropdownButton<String>(
                  value: selectedSize,
                  items: widget.food.availableSizes
                      .map((size) => DropdownMenuItem<String>(
                            value: size,
                            child: Text(size),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSize = newValue!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Text('Toppings:'),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: widget.food.availableToppings
                  .map((topping) => ChoiceChip(
                        label: Text(topping),
                        selected: selectedToppings.contains(topping),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              selectedToppings.add(topping);
                            } else {
                              selectedToppings.remove(topping);
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const Text('Quantity:'),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) {
                        quantity--;
                      }
                    });
                  },
                ),
                Text(quantity.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                OrderFoodItem orderFoodItem = OrderFoodItem(
                  food: widget.food,
                  selectedSize: selectedSize,
                  selectedToppings: selectedToppings,
                  quantity: quantity,
                );
                widget.addToCart(orderFoodItem);
                quantity = 1;
                selectedToppings = [];
                selectedSize = 'Small';
              },
              style: AppStyles.darkButton,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
