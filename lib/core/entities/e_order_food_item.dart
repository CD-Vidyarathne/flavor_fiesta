import 'package:flavor_fiesta/core/entities/e_food.dart';

class OrderFoodItem {
  final Food food;
  final String selectedSize;
  final List<String> selectedToppings;
  double price;
  int quantity;

  OrderFoodItem(
      {required this.food,
      required this.selectedSize,
      required this.selectedToppings,
      this.quantity = 1})
      : price = calculatePrice(food, selectedSize, selectedToppings, quantity);

  static double calculatePrice(Food food, String selectedSize,
      List<String> selectedToppings, int quantity) {
    double basePrice = food.price;
    double sizePrice = 0;

    if (selectedSize == 'Medium') {
      sizePrice = food.priceInForMd;
    } else if (selectedSize == 'Large') {
      sizePrice = food.priceInForLg;
    }

    double toppingsPrice = selectedToppings.length * 200;

    return (basePrice + sizePrice + toppingsPrice) * quantity;
  }

  @override
  String toString() {
    return 'OrderFoodItem(name: $food.name, size: $selectedSize, toppings: $selectedToppings, price: $price)';
  }
}
