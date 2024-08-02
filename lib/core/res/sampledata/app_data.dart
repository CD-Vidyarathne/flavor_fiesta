import 'package:flavor_fiesta/core/entities/e_food.dart';
import 'package:flavor_fiesta/core/entities/e_order.dart';
import 'package:flavor_fiesta/core/entities/e_order_food_item.dart';
import 'package:flavor_fiesta/core/entities/e_shop.dart';

// -----Sample Foods----
Food chiliChicken = Food(
  foodId: '001',
  name: 'Chili Chicken Pizza',
  availableSizes: ['Small', 'Medium', 'Large'],
  availableToppings: ['Extra Cheese', 'Olives', 'Mushrooms'],
  price: 1000,
  priceInForMd: 200,
  priceInForLg: 400,
);

Food veggiePizza = Food(
  foodId: '002',
  name: 'Veggie Pizza',
  availableSizes: ['Small', 'Medium', 'Large'],
  availableToppings: ['Extra Cheese', 'Olives', 'Pineapple'],
  price: 1200,
  priceInForMd: 250,
  priceInForLg: 500,
);

Food pepperoniPizza = Food(
  foodId: '003',
  name: 'Pepperoni Pizza',
  availableSizes: ['Small', 'Medium', 'Large'],
  availableToppings: ['Extra Cheese', 'Olives', 'Pineapple'],
  price: 900,
  priceInForMd: 150,
  priceInForLg: 300,
);

Food margheritaPizza = Food(
  foodId: '004',
  name: 'Margherita Pizza',
  availableSizes: ['Small', 'Medium', 'Large'],
  availableToppings: ['Basil', 'Tomatoes', 'Mozzarella'],
  price: 850,
  priceInForMd: 100,
  priceInForLg: 200,
);
// -----Sample Shops----
Shop shop1 = Shop(
  shopId: '328',
  location: 'Nugegoda',
  availableItems: [
    chiliChicken.foodId,
    veggiePizza.foodId,
    pepperoniPizza.foodId,
    margheritaPizza.foodId
  ],
);

Shop shop2 = Shop(
  shopId: '329',
  location: 'Colombo',
  availableItems: [pepperoniPizza.foodId, margheritaPizza.foodId],
);

Shop shop3 = Shop(
  shopId: '330',
  location: 'Kandy',
  availableItems: [
    veggiePizza.foodId,
    chiliChicken.foodId,
    pepperoniPizza.foodId
  ],
);

// -----Sample items----
OrderFoodItem orderFoodItem1 = OrderFoodItem(
  food: chiliChicken,
  selectedSize: 'Medium',
  selectedToppings: ['Extra Cheese', 'Olives'],
);

OrderFoodItem orderFoodItem2 = OrderFoodItem(
  food: veggiePizza,
  selectedSize: 'Large',
  selectedToppings: ['Pineapple'],
);

OrderFoodItem orderFoodItem3 = OrderFoodItem(
  food: pepperoniPizza,
  selectedSize: 'Small',
  selectedToppings: ['Extra Cheese', 'Olives'],
);

OrderFoodItem orderFoodItem4 = OrderFoodItem(
  food: margheritaPizza,
  selectedSize: 'Large',
  selectedToppings: ['Basil', 'Tomatoes'],
);
// -----Sample Orders-----

Order order1 = Order(
  orderId: '22784',
  userId: '4345',
  shop: shop1,
  foods: [orderFoodItem1, orderFoodItem2],
  totalPrice: orderFoodItem1.price + orderFoodItem2.price,
  date: DateTime.parse('2024-05-20'),
  paymentMethod: 'Credit Card',
  deliveryLocation: 'sampleAddress',
);

Order order2 = Order(
  orderId: '34783',
  userId: '4345',
  shop: shop2,
  foods: [orderFoodItem3, orderFoodItem4],
  totalPrice: orderFoodItem3.price + orderFoodItem4.price,
  date: DateTime.parse('2024-05-21'),
  paymentMethod: 'Cash on Delivery',
  deliveryLocation: 'sampleAddress2',
);

Order order3 = Order(
  orderId: '87573',
  userId: '4345',
  shop: shop3,
  foods: [orderFoodItem1, orderFoodItem3],
  totalPrice: orderFoodItem1.price + orderFoodItem3.price,
  date: DateTime.parse('2024-05-22'),
  paymentMethod: 'PayPal',
  deliveryLocation: 'sampleAddress3',
);

List<Food> foodData = [
  chiliChicken,
  veggiePizza,
  margheritaPizza,
  pepperoniPizza
];
List<Shop> shopData = [shop1, shop2, shop3];
List<Order> orderData = [order1, order2, order3];
