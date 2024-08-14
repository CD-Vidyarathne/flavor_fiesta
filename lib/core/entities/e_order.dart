import 'package:flavor_fiesta/core/entities/e_order_food_item.dart';
import 'package:flavor_fiesta/core/entities/e_shop.dart';

class AppOrder {
  String orderId;
  final String userEmail;
  final String shopId;
  final List<dynamic> foods;
  final double totalPrice;
  String? promoCode;
  final DateTime date;
  final String paymentMethod;
  final String deliveryLocation;
  String status;

  AppOrder(
      {this.orderId = "",
      required this.userEmail,
      required this.shopId,
      required this.foods,
      required this.totalPrice,
      required this.date,
      required this.paymentMethod,
      this.promoCode = "",
      required this.deliveryLocation,
      required this.status});

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'shopId': shopId,
      'foods': foods.map((food) => food.toMap()).toList(),
      'totalPrice': totalPrice,
      'promoCode': promoCode,
      'date': date.toIso8601String(),
      'paymentMethod': paymentMethod,
      'deliveryLocation': deliveryLocation,
      'status': status,
    };
  }

  @override
  String toString() {
    return 'Order(orderId: $orderId, userId: $userEmail, shop: $shopId.location, foods: $foods, totalPrice: $totalPrice, date: $date, paymentMethod: $paymentMethod, deliveryLocation: $deliveryLocation)';
  }
}
