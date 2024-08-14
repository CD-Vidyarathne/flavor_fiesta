import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_fiesta/core/entities/e_cart.dart';
import 'package:flavor_fiesta/core/entities/e_food.dart';
import 'package:flavor_fiesta/core/helpers/helper_functions.dart';
import 'package:flavor_fiesta/core/res/routes/app_routes.dart';
import 'package:flavor_fiesta/core/entities/e_shop.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flavor_fiesta/core/widgets/single_food_card.dart';
import 'package:flavor_fiesta/screens/google_map_screen.dart';
import 'package:flavor_fiesta/screens/view_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fiesta/core/entities/e_order_food_item.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderNowScreen extends StatefulWidget {
  const OrderNowScreen({super.key});

  @override
  _OrderNowScreenState createState() => _OrderNowScreenState();
}

class _OrderNowScreenState extends State<OrderNowScreen> {
  List<Shop> shops = [];
  String? _selectedShopId;

  final Cart cart = Cart.instance;

  @override
  void initState() {
    super.initState();
    fetchShops();
  }

  Future<void> fetchShops() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Shops').get();
      final List<Shop> loadedShops = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Shop(
          shopId: doc.id,
          location: data['location'],
          mapLocation: LatLng(data['mapLocation']['latitude'],
              data['mapLocation']['longitude']),
          availableItems: List<String>.from(data['availableItems']),
        );
      }).toList();

      setState(() {
        shops = loadedShops;
      });
    } catch (e) {
      displayMessageToUser('Error fetching shops: $e', context);
    }
  }

  Future<Shop> getSelectedShop() async {
    if (_selectedShopId == null) {
      return Shop(
          shopId: '',
          location: '',
          mapLocation: const LatLng(0, 0),
          availableItems: []);
    }
    try {
      final DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Shops')
          .doc(_selectedShopId)
          .get();
      final data = doc.data() as Map<String, dynamic>;
      return Shop(
        shopId: doc.id,
        location: data['location'],
        mapLocation: LatLng(
            data['mapLocation']['latitude'], data['mapLocation']['longitude']),
        availableItems: List<String>.from(data['availableItems']),
      );
    } catch (e) {
      displayMessageToUser('Error fetching shop details: $e', context);
      return Shop(
          shopId: '',
          location: '',
          mapLocation: const LatLng(0, 0),
          availableItems: []);
    }
  }

  Future<Food> getFoodByFoodId(String id) async {
    try {
      final DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('Foods').doc(id).get();
      final data = doc.data() as Map<String, dynamic>;
      return Food(
          foodId: doc.id,
          name: data['name'],
          availableSizes: List<String>.from(data['availableSizes']),
          availableToppings: List<String>.from(data['availableToppings']),
          price: data['price'],
          priceInForMd: data['priceInForMd'],
          priceInForLg: data['priceInForLg']);
    } catch (e) {
      displayMessageToUser('Error fetching food details: $e', context);
      return Food(
          foodId: '',
          name: '',
          availableSizes: [],
          availableToppings: [],
          price: 0);
    }
  }

  void addToCart(OrderFoodItem orderFoodItem) {
    setState(() {
      cart.addItem(orderFoodItem);
    });
  }

  void clearCart() {
    setState(() {
      cart.clearCart();
    });
  }

  void onShopChanged(String? newValue) {
    setState(() {
      _selectedShopId = newValue;
      clearCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Shop>(
      future: getSelectedShop(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            appBar: const CustomAppbar(
              title: 'Order Now',
              showBackButton: false,
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: const CustomAppbar(
              title: 'Order Now',
              showBackButton: false,
            ),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final selectedShop = snapshot.data!;
        return FutureBuilder<List<Food>>(
          future: Future.wait(
            selectedShop.availableItems
                .map((foodId) => getFoodByFoodId(foodId)),
          ),
          builder: (context, foodSnapshot) {
            if (foodSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                appBar: const CustomAppbar(
                  title: 'Order Now',
                  showBackButton: false,
                ),
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (foodSnapshot.hasError) {
              return Scaffold(
                appBar: const CustomAppbar(
                  title: 'Order Now',
                  showBackButton: false,
                ),
                body: Center(child: Text('Error: ${foodSnapshot.error}')),
              );
            }

            final foodsOfShop = foodSnapshot.data ?? [];

            final size = MediaQuery.of(context).size;

            return Scaffold(
                appBar: const CustomAppbar(
                  title: 'Order Now',
                  showBackButton: false,
                ),
                body: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.all(20),
                            child: SizedBox(
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownButton<String>(
                                    hint: const Text('Select Branch'),
                                    value: _selectedShopId,
                                    items: shops
                                        .map((shop) => DropdownMenuItem<String>(
                                              value: shop.shopId,
                                              child: Text(shop.location),
                                            ))
                                        .toList(),
                                    onChanged: onShopChanged,
                                    style: AppStyles.textBlackStyle1
                                        .copyWith(fontSize: 20),
                                    dropdownColor: AppStyles.paletteLight,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: AppStyles.paletteBlack,
                                    ),
                                    iconSize: 24,
                                    underline: Container(
                                      height: 2,
                                      color: AppStyles.paletteDark,
                                    ),
                                    isExpanded: true,
                                  ),
                                  const SizedBox(height: 16),
                                  InkWell(
                                    onTap: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GoogleMapScreen(shops: shops)),
                                      )
                                    },
                                    child: Text(
                                      'Find the nearest branch>>',
                                      style: AppStyles.textBlackStyle1,
                                    ),
                                  ),
                                  if (selectedShop.shopId != "")
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 16),
                                        Column(
                                          children: foodsOfShop
                                              .map((food) => SingleFoodCard(
                                                    food: food,
                                                    addToCart: addToCart,
                                                  ))
                                              .toList(),
                                        )
                                      ],
                                    ),
                                  const SizedBox(height: 50)
                                  //default
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        width: size.width,
                        child: Container(
                          color: AppStyles.paletteDark,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewCartScreen(
                                            cart: cart,
                                            shopId: selectedShop.shopId)),
                                  );
                                },
                                style: AppStyles.lightButton,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'View Cart',
                                      style: AppStyles.headLineStyle3.copyWith(
                                          color: AppStyles.paletteBlack),
                                    ),
                                    Icon(
                                      Icons.shopping_cart,
                                      size: 24.0,
                                      color: AppStyles.paletteBlack,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: clearCart,
                                style: AppStyles.lightButton,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Clear Cart',
                                      style: AppStyles.headLineStyle3.copyWith(
                                          color: AppStyles.paletteBlack),
                                    ),
                                    Icon(
                                      Icons.clear,
                                      size: 24.0,
                                      color: AppStyles.paletteBlack,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ));
          },
        );
      },
    );
  }
}

