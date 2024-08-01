import 'package:flavor_fiesta/core/entities/e_order.dart';
import 'package:flavor_fiesta/core/entities/e_order_food_item.dart';

// -----Sample items----
OrderFoodItem item1 = OrderFoodItem(
  name: 'Chili chicken Pizza',
  size: 'Medium',
  toppings: ['Extra cheese', 'Olives'],
  price: 1000,
);

OrderFoodItem item2 = OrderFoodItem(
  name: 'Veggie Pizza',
  size: 'Large',
  toppings: ['Pineapple'],
  price: 1200,
);

OrderFoodItem item3 = OrderFoodItem(
  name: 'Pepperoni Pizza',
  size: 'Small',
  toppings: ['Extra cheese', 'Olives'],
  price: 900,
);

// -----Sample Orders-----
Order order1 = Order(
  orderId: '22784',
  userId: '4345',
  shopId: '328',
  foods: [item1, item2],
  shop: 'Nugegoda',
  totalPrice: 2200,
  date: DateTime.parse('2024-05-20'),
  paymentMethod: 'Credit Card',
  deliveryLocation: 'sampleAddress',
);

Order order2 = Order(
  orderId: '34783',
  userId: '4345',
  shopId: '329',
  foods: [item3],
  shop: 'Colombo',
  totalPrice: 900,
  date: DateTime.parse('2024-05-21'),
  paymentMethod: 'Cash on Delivery',
  deliveryLocation: 'sampleAddress2',
);

Order order3 = Order(
  orderId: '87573',
  userId: '4345',
  shopId: '330',
  foods: [item1, item3],
  shop: 'Kandy',
  totalPrice: 1900,
  date: DateTime.parse('2024-05-22'),
  paymentMethod: 'PayPal',
  deliveryLocation: 'sampleAddress3',
);

List<Order> orderData = [order1, order2, order3];
