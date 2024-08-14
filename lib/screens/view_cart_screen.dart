import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fiesta/core/entities/e_cart.dart';
import 'package:flavor_fiesta/core/helpers/helper_functions.dart';
import 'package:flavor_fiesta/core/res/constants/promo_codes.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flavor_fiesta/core/widgets/delivery_details.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fiesta/core/entities/e_order_food_item.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flavor_fiesta/core/widgets/single_cart_item.dart';
import 'package:flavor_fiesta/core/entities/e_order.dart';

class ViewCartScreen extends StatefulWidget {
  final Cart cart;
  final String shopId;

  const ViewCartScreen({super.key, required this.cart, required this.shopId});

  @override
  _ViewCartScreenState createState() => _ViewCartScreenState();
}

class _ViewCartScreenState extends State<ViewCartScreen> {
  final TextEditingController promoCodeController = TextEditingController();
  PromoCode? appliedPromoCode;

  final User? currentUser = FirebaseAuth.instance.currentUser;
  void handleRemove(OrderFoodItem item) {
    setState(() {
      widget.cart.removeItem(item);
    });
  }

  void handleQuantityChange(OrderFoodItem item, int newQuantity) {
    setState(() {
      widget.cart.updateItemQuantity(item, newQuantity);
    });
  }

  void applyPromoCode() {
    setState(() {
      switch (promoCodeController.text) {
        case 'FB10':
          appliedPromoCode = PromoCode.FB10;
          break;
        case 'FB20':
          appliedPromoCode = PromoCode.FB20;
          break;
        case 'FB30':
          appliedPromoCode = PromoCode.FB30;
          break;
        default:
          appliedPromoCode = null;
          break;
      }
      promoCodeController.text = "";
    });
  }

  double getTotalPrice() {
    double total = widget.cart.items.fold(0.0, (total, item) {
      return total +
          OrderFoodItem.calculatePrice(item.food, item.selectedSize,
              item.selectedToppings, item.quantity);
    });
    if (appliedPromoCode != null) {
      total -= total * appliedPromoCode!.discount;
    }
    return total;
  }

  void checkout() async {
    final order = AppOrder(
      userEmail: currentUser!.email!,
      shopId: widget.shopId,
      foods: widget.cart.items,
      totalPrice: getTotalPrice(),
      date: DateTime.now(),
      paymentMethod: "Credit Card",
      deliveryLocation: "userAddress",
      status: "Waiting",
      promoCode: appliedPromoCode != null ? appliedPromoCode.toString() : null,
    );

    await FirebaseFirestore.instance
        .collection('Orders')
        .doc()
        .set(order.toMap());

    displayMessageToUser("Order Created", context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Your Cart'),
      body: widget.cart.items.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty',
                style: AppStyles.textBlackStyle1,
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Column(
                      children: widget.cart.items
                          .map((item) => SingleCartItem(
                                orderFoodItem: item,
                                onRemove: handleRemove,
                                onQuantityChange: handleQuantityChange,
                              ))
                          .toList()),
                  const DeliveryDetails(initialAddress: "sample"),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: promoCodeController,
                          decoration: const InputDecoration(
                            labelText: 'Enter Promo Code',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: applyPromoCode,
                          style: AppStyles.darkButton,
                          child: Text('Apply Promo Code',
                              style: AppStyles.headLineStyle3
                                  .copyWith(color: AppStyles.paletteLight)),
                        ),
                        appliedPromoCode != null
                            ? Text(
                                'Applied Promo Code: ${appliedPromoCode.toString().split('.')[1]}',
                                style: AppStyles.textBlackStyle2,
                              )
                            : Text(
                                'Invalid Promo Code',
                                style: AppStyles.textBlackStyle2
                                    .copyWith(color: AppStyles.redColor),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16.0),
          color: AppStyles.paletteDark,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Total: Rs.${getTotalPrice().toStringAsFixed(2)}',
              style: AppStyles.textBlackStyle1,
            ),
            ElevatedButton(
              onPressed: checkout,
              style: AppStyles.darkButton,
              child: Text('Checkout',
                  style: AppStyles.headLineStyle3
                      .copyWith(color: AppStyles.paletteLight)),
            ),
          ])),
    );
  }
}
