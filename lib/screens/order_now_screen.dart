import 'package:flavor_fiesta/core/entities/e_cart.dart';
import 'package:flavor_fiesta/core/entities/e_food.dart';
import 'package:flavor_fiesta/core/res/sampledata/app_data.dart';
import 'package:flavor_fiesta/core/entities/e_shop.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flavor_fiesta/core/widgets/single_food_card.dart';
import 'package:flavor_fiesta/screens/view_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fiesta/core/entities/e_order_food_item.dart';

class OrderNowScreen extends StatefulWidget {
  const OrderNowScreen({super.key});

  @override
  _OrderNowScreenState createState() => _OrderNowScreenState();
}

class _OrderNowScreenState extends State<OrderNowScreen> {
  final List<Shop> shops = shopData;
  final List<Food> foods = foodData;
  String? _selectedShopId;

  final Cart cart = Cart.instance;

  Shop getSelectedShop() {
    return shops.firstWhere((shop) => shop.shopId == _selectedShopId,
        orElse: () => Shop(shopId: '', location: ''));
  }

  Food getFoodByFoodId(String id) {
    return foods.firstWhere((food) => food.foodId == id,
        orElse: () => Food(
            foodId: '',
            name: '',
            availableSizes: [],
            availableToppings: [],
            price: 0));
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
      // Clear cart when the branch is changed
      clearCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    Shop selectedShop = getSelectedShop();

    List<Food> foodsOfShop = selectedShop.availableItems
        .map((foodId) => getFoodByFoodId(foodId))
        .toList();

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
                          Text(
                            'Find the nearest branch>>',
                            style: AppStyles.textBlackStyle1,
                          ),
                          if (selectedShop.shopId != "")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewCartScreen(cartItems: cart.items)),
                          );
                        },
                        style: AppStyles.lightButton,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'View Cart',
                              style: AppStyles.headLineStyle3
                                  .copyWith(color: AppStyles.paletteBlack),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Clear Cart',
                              style: AppStyles.headLineStyle3
                                  .copyWith(color: AppStyles.paletteBlack),
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
  }
}
