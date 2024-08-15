import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fiesta/core/entities/e_order.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flavor_fiesta/core/widgets/single_order_card.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  Future<List<Map<String, dynamic>>> _fetchOrderHistory() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return [];
    }

    final userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.email)
        .get();

    print(userDoc.data());

    final List<dynamic> previousOrderIds =
        userDoc.data()?['previousOrders'] ?? [];

    List<Map<String, dynamic>> orders = [];
    for (String orderId in previousOrderIds) {
      final orderDoc = await FirebaseFirestore.instance
          .collection('Orders')
          .doc(orderId)
          .get();
      if (orderDoc.exists) {
        orders.add(orderDoc.data()!);
      }
    }

    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Order History', showBackButton: false),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchOrderHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No order history available.'));
          } else {
            final orders = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: orders.map((order) {
                  AppOrder o = AppOrder(
                      userEmail: order["userEmail"],
                      shopId: order["shopId"],
                      foods: order["foods"],
                      totalPrice: order["totalPrice"],
                      promoCode: order["promoCode"],
                      date: order["date"],
                      paymentMethod: order["paymentMethod"],
                      deliveryLocation: order["deliveryLocation"],
                      status: "Completed");
                  return SingleOrderCard(order: o);
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

