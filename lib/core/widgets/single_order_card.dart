import 'package:flavor_fiesta/core/entities/e_order.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flavor_fiesta/screens/order_details_screen.dart';
import 'package:flutter/material.dart';

class SingleOrderCard extends StatelessWidget {
  final Order order;

  const SingleOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 5.0,
      child: Container(
        width: size.width,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order ID : #${order.orderId}",
              style: AppStyles.textBlackStyle1,
            ),
            const SizedBox(height: 10.0),
            Text(
              "${order.foods[0].name}....",
              style: AppStyles.textBlackStyle1,
            ),
            const SizedBox(height: 10.0),
            Text(
              '${order.shop} shop',
              style: AppStyles.textBlackStyle2,
            ),
            const SizedBox(height: 10.0),
            Text(
              'Total Price: Rs.${order.totalPrice.toStringAsFixed(2)}',
              style: AppStyles.textBlackStyle2,
            ),
            const SizedBox(height: 10.0),
            Text(
              order.date.toLocal().toString().split(' ')[0],
              style: AppStyles.textBlackStyle2,
            ),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailsScreen(order: order),
                  ),
                );
              },
              child: Text(
                'View More >> ',
                style: AppStyles.textBlackStyle2
                    .copyWith(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
