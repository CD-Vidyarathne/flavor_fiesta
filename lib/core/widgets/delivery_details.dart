import 'package:flutter/material.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';

class DeliveryDetails extends StatefulWidget {
  final String initialAddress;
  const DeliveryDetails({
    super.key,
    required this.initialAddress,
  });

  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  late TextEditingController _addressController;
  String? displayingAddress;
  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.initialAddress);
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  void _handleChange() {
    setState(() {
      displayingAddress = _addressController.text;
    });
  }

  void _handleReset() {
    setState(() {
      displayingAddress = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Delivery Address',
            style:
                AppStyles.textBlackStyle1.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: AppStyles.paletteDark, width: 1.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              displayingAddress ?? widget.initialAddress,
              style: AppStyles.textBlackStyle2,
            ),
          ),
          ElevatedButton(
            onPressed: _handleReset,
            style: AppStyles.darkButton,
            child: const Text('Reset'),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Change Delivery Address',
            style:
                AppStyles.textBlackStyle1.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: _addressController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'New Address',
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _handleChange,
            style: AppStyles.darkButton,
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }
}
