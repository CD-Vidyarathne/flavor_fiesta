import 'package:flavor_fiesta/core/entities/e_order_food_item.dart';

class Order {
  final String orderId;
  final String userId;
  final String shopId;
  final List<OrderFoodItem> foods;
  final String shop;
  final double totalPrice;
  final DateTime date;
  final String paymentMethod;
  final String deliveryLocation;

  Order({
    required this.orderId,
    required this.userId,
    required this.shopId,
    required this.foods,
    required this.shop,
    required this.totalPrice,
    required this.date,
    required this.paymentMethod,
    required this.deliveryLocation,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'],
      userId: map['userId'],
      shopId: map['shopId'],
      foods: List<OrderFoodItem>.from(
        map['foods'].map((foodMap) => OrderFoodItem.fromMap(foodMap)),
      ),
      shop: map['shop'],
      totalPrice: map['totalPrice'],
      date: DateTime.parse(map['date']),
      paymentMethod: map['paymentMethod'],
      deliveryLocation: map['deliveryLocation'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'shopId': shopId,
      'foods': foods.map((food) => food.toMap()).toList(),
      'shop': shop,
      'totalPrice': totalPrice,
      'date': date.toIso8601String(),
      'paymentMethod': paymentMethod,
      'deliveryLocation': deliveryLocation,
    };
  }

  @override
  String toString() {
    return 'Order(orderId: $orderId, userId: $userId, shopId: $shopId, foods: $foods, shop: $shop, totalPrice: $totalPrice, date: $date, paymentMethod: $paymentMethod, deliveryLocation: $deliveryLocation)';
  }
}
