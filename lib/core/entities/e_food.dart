class Food {
  final String name;
  final List<String> availableSizes;
  final List<String> availableToppings;
  final double price;

  Food(
      {required this.name,
      required this.availableSizes,
      required this.availableToppings,
      required this.price});

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
        name: map['name'],
        availableSizes: List<String>.from(map['availableSizes']),
        availableToppings: List<String>.from(map['availableToppings']),
        price: map['price']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'availableSizes': availableSizes,
      'availableToppings': availableToppings,
      'price': price
    };
  }

  @override
  String toString() {
    return 'Food(name: $name, availableSizes: $availableSizes, availableToppings: $availableToppings, price: $price)';
  }
}
