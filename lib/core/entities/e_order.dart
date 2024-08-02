import 'package:flavor_fiesta/core/entities/e_order_food_item.dart';
import 'package:flavor_fiesta/core/entities/e_shop.dart';

class Order {
  final String orderId;
  final String userId;
  final Shop shop;
  final List<OrderFoodItem> foods;
  final double totalPrice;
  final DateTime date;
  final String paymentMethod;
  final String deliveryLocation;

  Order({
    required this.orderId,
    required this.userId,
    required this.shop,
    required this.foods,
    required this.totalPrice,
    required this.date,
    required this.paymentMethod,
    required this.deliveryLocation,
  });

  @override
  String toString() {
    return 'Order(orderId: $orderId, userId: $userId, shop: $shop.location, foods: $foods, totalPrice: $totalPrice, date: $date, paymentMethod: $paymentMethod, deliveryLocation: $deliveryLocation)';
  }
}
