import 'package:flavor_fiesta/core/entities/e_order_food_item.dart';

class Cart {
  Cart._privateConstructor();

  static final Cart _instance = Cart._privateConstructor();

  static Cart get instance => _instance;

  final List<OrderFoodItem> items = [];

  void addItem(OrderFoodItem item) {
    items.add(item);
  }

  void removeItem(OrderFoodItem item) {
    items.remove(item);
  }

  void clearCart() {
    items.clear();
  }

  double getTotalPrice() {
    return items.fold(
      0,
      (total, current) => total + current.price * current.quantity,
    );
  }
}

