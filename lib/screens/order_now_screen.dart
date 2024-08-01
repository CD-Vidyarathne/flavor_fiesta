import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class OrderNowScreen extends StatelessWidget {
  const OrderNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Order Now',
        showBackButton: false,
      ),
    );
  }
}
