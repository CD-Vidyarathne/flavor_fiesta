import 'package:flavor_fiesta/core/entities/e_order_food_item.dart';

class Cart {
  Cart._privateConstructor();

  static final Cart _instance = Cart._privateConstructor();

  static Cart get instance => _instance;

  final List<OrderFoodItem> items = [];

  void addItem(OrderFoodItem newItem) {
    for (OrderFoodItem item in items) {
      if (item.food.foodId == newItem.food.foodId &&
          item.selectedSize == newItem.selectedSize &&
          _listsAreEqual(item.selectedToppings, newItem.selectedToppings)) {
        item.quantity += newItem.quantity;
        item.price = OrderFoodItem.calculatePrice(
            item.food, item.selectedSize, item.selectedToppings, item.quantity);
        return;
      }
    }
    items.add(newItem);
  }

  void removeItem(OrderFoodItem item) {
    items.remove(item);
  }

  void clearCart() {
    items.clear();
  }

  void updateItemQuantity(OrderFoodItem item, int newQuantity) {
    item.quantity = newQuantity;
    item.price = OrderFoodItem.calculatePrice(
        item.food, item.selectedSize, item.selectedToppings, item.quantity);
  }

  double getTotalPrice() {
    return items.fold(
      0,
      (total, current) => total + current.price * current.quantity,
    );
  }

  bool _listsAreEqual(List<String> list1, List<String> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }
}
