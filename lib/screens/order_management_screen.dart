import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_fiesta/core/entities/e_order.dart';
import 'package:flavor_fiesta/core/helpers/helper_functions.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<AppOrder> _orders = [];
  String _selectedFilter = 'Waiting';

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  void _fetchOrders() async {
    QuerySnapshot snapshot = await _firestore.collection('Orders').get();
    List<AppOrder> orders = snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return AppOrder(
        orderId: doc.id,
        userEmail: data['userEmail'],
        shopId: data['shopId'],
        foods: data['foods'],
        totalPrice: data['totalPrice'],
        date: DateTime.parse(data['date']),
        paymentMethod: data['paymentMethod'],
        deliveryLocation: data['deliveryLocation'],
        status: data['status'],
        promoCode: data['promoCode'],
      );
    }).toList();

    setState(() {
      _orders = orders;
    });
  }

  void _filterOrders(String status) {
    setState(() {
      _selectedFilter = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<AppOrder> filteredOrders =
        _orders.where((order) => order.status == _selectedFilter).toList();

    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Order Management',
        showBackButton: false,
      ),
      body: Column(
        children: [
          // Filter buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _filterOrders('Waiting'),
                  style: AppStyles.lightButton,
                  child: const Text('Waiting'),
                ),
                ElevatedButton(
                  onPressed: () => _filterOrders('Ongoing'),
                  style: AppStyles.lightButton,
                  child: const Text('Ongoing'),
                ),
                ElevatedButton(
                  onPressed: () => _filterOrders('Completed'),
                  style: AppStyles.lightButton,
                  child: const Text('Completed'),
                ),
              ],
            ),
          ),
          // Order list
          Expanded(
            child: ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Order ID: ${order.orderId}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Items: ${order.foods.map((food) => '${food["food"]} (${food["selectedSize"]})').join(', ')}',
                            ),
                            Text('Total Price: ${order.totalPrice.toString()}'),
                            Text('Payment Method: ${order.paymentMethod}'),
                            Text(
                                'Delivery Location: ${order.deliveryLocation}'),
                          ],
                        ),
                      ),
                      const Divider(
                          height:
                              1.0), // Optional: Adds a divider line between the ListTile and buttons
                      OverflowBar(
                        alignment: MainAxisAlignment.end,
                        children: [_buildActionButtons(order)],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(AppOrder order) {
    switch (order.status) {
      case 'Waiting':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => _updateOrderStatus(order, 'Ongoing'),
              style: AppStyles.darkButton,
              child: const Text('Accept'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => _removeOrder(order),
              style: AppStyles.redButton,
              child: const Text('Decline'),
            ),
          ],
        );
      case 'Ongoing':
        return ElevatedButton(
          onPressed: () => _updateOrderStatus(order, 'Completed'),
          style: AppStyles.darkButton,
          child: const Text('Complete'),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void sendEmail(String body, String userEmail) async {
    final Email email = Email(
      body: body,
      subject: 'Flutter Fiesta Order Status',
      recipients: [userEmail],
      isHTML: false,
    );
    String platformResponse;
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'Success';
      displayMessageToUser(platformResponse, context);
    } catch (error) {
      platformResponse = error.toString();
      displayMessageToUser(platformResponse, context);
    }
  }

  void _updateOrderStatus(AppOrder order, String status) async {
    final firestore = FirebaseFirestore.instance;

    // Update the order status
    firestore
        .collection('Orders')
        .doc(order.orderId)
        .update({'status': status}).then((_) {
      setState(() {
        order.status = status;
      });

      // If the status is "Completed", update the user's previousOrders
      if (status == "Completed") {
        sendEmail('Your order is completed', order.userEmail);
        _updateUserPreviousOrders(order.userEmail, order.orderId);
      }
      if (status == "Ongoing") {
        sendEmail('Your order is Accepted. Order Processing.', order.userEmail);
      }
    }).catchError((error) {
      displayMessageToUser("Something went wrong.", context);
    });
  }

  void _updateUserPreviousOrders(String userEmail, String orderId) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();

      if (userDoc.docs.isNotEmpty) {
        final userId = userDoc.docs.first.id;

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .update({
          'previousOrders': FieldValue.arrayUnion([orderId])
        });
      } else {
        displayMessageToUser("User not found.", context);
      }
    } catch (error) {
      displayMessageToUser("Failed to update user orders.", context);
    }
  }

  void _removeOrder(AppOrder order) {
    _firestore.collection('Orders').doc(order.orderId).delete().then((_) {
      setState(() {
        _orders.remove(order);
      });
    }).catchError((error) {
      displayMessageToUser("Something went wrong.", context);
    });
  }
}
