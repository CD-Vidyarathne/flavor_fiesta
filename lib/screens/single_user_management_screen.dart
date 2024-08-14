import 'package:flavor_fiesta/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class SingleUserManagementScreen extends StatelessWidget {
  final userData;

  const SingleUserManagementScreen({
    super.key,
    required this.userData,
  });

  // void _deleteUser(BuildContext context) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(userData['email'])
  //         .delete();
  //     Navigator.pushNamed(context, AppRoutes.authenticated);
  //     displayMessageToUser("User Deleted", context);
  //   } catch (e) {
  //     displayMessageToUser("Error deleting user: $e", context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: userData["userName"],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User ID: ${userData["userId"]}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Email: ${userData["email"]}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Default Address: ${userData["defaultAddress"] ?? "N/A"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () => _deleteUser(context),
            //   child: const Text('Delete User'),
            // ),
          ],
        ),
      ),
    );
  }
}
