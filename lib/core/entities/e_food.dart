class Food {
  final String foodId;
  final String name;
  final List<String> availableSizes;
  final List<String> availableToppings;
  final double price;
  final double priceInForSm = 0;
  final double priceInForMd;
  final double priceInForLg;

  Food(
      {required this.foodId,
      required this.name,
      required this.availableSizes,
      required this.availableToppings,
      required this.price,
      this.priceInForMd = 0,
      this.priceInForLg = 0});
  Map<String, dynamic> toMap() {
    return {
      'foodId': foodId,
      'name': name,
      'availableSizes': availableSizes,
      'availableToppings': availableToppings,
      'price': price,
      'priceInForSm': priceInForSm,
      'priceInForMd': priceInForMd,
      'priceInForLg': priceInForLg,
    };
  }

  @override
  String toString() {
    return 'Food(name: $name, availableSizes: $availableSizes, availableToppings: $availableToppings, price: $price)';
  }
}
