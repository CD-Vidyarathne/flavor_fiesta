import 'package:flavor_fiesta/core/res/sampledata/app_data.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flavor_fiesta/core/widgets/single_order_card.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Order History', showBackButton: false),
      // body: SingleChildScrollView(
      //     scrollDirection: Axis.vertical,
      //     child: Column(
      //       children: orderData
      //           .map((order) => SingleOrderCard(order: order))
      //           .toList(),
      //     ))
    );
  }
}
