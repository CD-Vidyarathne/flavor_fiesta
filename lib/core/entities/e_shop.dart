class Shop {
  final String shopId;
  final String location;
  List<String> availableItems = [];

  Shop({
    required this.shopId,
    required this.location,
    List<String>? availableItems,
  }) : availableItems = availableItems ?? [];

  void addFood(String foodId) {
    availableItems.add(foodId);
  }

  void removeFood(String foodId) {
    availableItems.remove(foodId);
  }
}
