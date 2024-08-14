import 'package:flavor_fiesta/core/entities/e_food.dart';
import 'package:flavor_fiesta/core/entities/e_order.dart';
import 'package:flavor_fiesta/core/entities/e_order_food_item.dart';
import 'package:flavor_fiesta/core/entities/e_shop.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  location: 'Arcade Square',
  mapLocation: const LatLng(6.902888498043025, 79.86938023168656),
  availableItems: [
    chiliChicken.foodId,
    veggiePizza.foodId,
    pepperoniPizza.foodId,
    margheritaPizza.foodId
  ],
);

Shop shop2 = Shop(
  shopId: '329',
  location: 'Boralla',
  mapLocation: const LatLng(6.909686196053032, 79.87722206646745),
  availableItems: [pepperoniPizza.foodId, margheritaPizza.foodId],
);

Shop shop3 = Shop(
  shopId: '330',
  location: 'Liberty Plaza',
  mapLocation: const LatLng(6.911988910408117, 79.85158322887986),
  availableItems: [
    veggiePizza.foodId,
    chiliChicken.foodId,
    pepperoniPizza.foodId
  ],
);

Shop shop4 = Shop(
  shopId: '331',
  location: 'Galle Face',
  mapLocation: const LatLng(6.926108128852529, 79.84464574248112),
  availableItems: [
    veggiePizza.foodId,
    chiliChicken.foodId,
    pepperoniPizza.foodId
  ],
);
Shop shop5 = Shop(
  shopId: '332',
  location: 'Maradana',
  mapLocation: const LatLng(6.929253109758005, 79.86397924895076),
  availableItems: [
    veggiePizza.foodId,
    chiliChicken.foodId,
    pepperoniPizza.foodId
  ],
);

Shop shop6 = Shop(
  shopId: '333',
  location: 'Pettah',
  mapLocation: const LatLng(6.936048914579842, 79.84294523321266),
  availableItems: [
    veggiePizza.foodId,
    chiliChicken.foodId,
    pepperoniPizza.foodId
  ],
);

Shop shop7 = Shop(
  shopId: '334',
  location: 'Peliyagoda',
  mapLocation: const LatLng(6.959062006221287, 79.89133102018832),
  availableItems: [
    veggiePizza.foodId,
    chiliChicken.foodId,
    pepperoniPizza.foodId
  ],
);

Shop shop8 = Shop(
  shopId: '335',
  location: 'Rajagiriya',
  mapLocation: const LatLng(6.9089563432413446, 79.89634880085082),
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

List<Food> foodData = [
  chiliChicken,
  veggiePizza,
  margheritaPizza,
  pepperoniPizza
];
List<Shop> shopData = [shop1, shop2, shop3, shop4, shop5, shop6, shop7, shop8];
