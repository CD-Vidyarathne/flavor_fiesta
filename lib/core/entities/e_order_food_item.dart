class OrderFoodItem {
  final String name;
  final String size;
  final List<String> toppings;
  final double price;

  OrderFoodItem(
      {required this.name,
      required this.size,
      required this.toppings,
      required this.price});

  factory OrderFoodItem.fromMap(Map<String, dynamic> map) {
    return OrderFoodItem(
        name: map['name'],
        size: map['size'],
        toppings: List<String>.from(map['toppings']),
        price: map['price']);
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'size': size, 'toppings': toppings, 'price': price};
  }

  @override
  String toString() {
    return 'OrderFoodItem(name: $name, size: $size, toppings: $toppings, price: $price)';
  }
}
