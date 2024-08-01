import 'package:flavor_fiesta/core/entities/e_order.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flavor_fiesta/core/widgets/single_ordered_food_item.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(title: 'Order Details : #${order.orderId}'),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Foods',
                style: AppStyles.headLineStyle1,
              ),
              Column(
                children: order.foods
                    .map((item) => SingleOrderFoodItem(item: item))
                    .toList(),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Total Price:', style: AppStyles.textBlackStyle1),
                Text(order.totalPrice.toStringAsFixed(2),
                    style: AppStyles.textBlackStyle1)
              ]),
              const SizedBox(height: 15.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Payment Method:', style: AppStyles.textBlackStyle1),
                Text(order.paymentMethod,
                    style: AppStyles.textBlackStyle1
                        .copyWith(fontWeight: FontWeight.w400))
              ]),
              const SizedBox(height: 40),
              Text(
                'Delivery Details',
                style: AppStyles.headLineStyle1,
              ),
              const SizedBox(height: 15.0),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  children: [
                    Text('Shop:',
                        style:
                            AppStyles.textBlackStyle1.copyWith(fontSize: 16)),
                    const SizedBox(width: 10),
                    Text(order.shop,
                        style: AppStyles.textBlackStyle1.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Text('Delivery Address:',
                        style:
                            AppStyles.textBlackStyle1.copyWith(fontSize: 16)),
                    const SizedBox(width: 10),
                    Text(order.deliveryLocation,
                        style: AppStyles.textBlackStyle1.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Text('Date:',
                        style:
                            AppStyles.textBlackStyle1.copyWith(fontSize: 16)),
                    const SizedBox(width: 10),
                    Text(order.date.toLocal().toString().split(' ')[0],
                        style: AppStyles.textBlackStyle1.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ],
                ),
              ]),
            ])));
  }
}
