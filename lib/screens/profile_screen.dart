import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fiesta/core/res/media/app_media.dart';
import 'package:flavor_fiesta/core/res/routes/app_routes.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  Uint8List? _image;
  File? selectedImage;

  @override
  void dispose() {
    addressController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  void logoutUser() {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, AppRoutes.login);
  }

  void _updateAddress() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.email)
            .update({'defaultAddress': addressController.text});
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Address updated successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update address: $e')),
      );
    }
  }

  void _changePassword() async {
    if (newPasswordController.text != confirmNewPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New passwords do not match.')),
      );
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPasswordController.text,
      );

      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPasswordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully!')),
      );

      currentPasswordController.clear();
      newPasswordController.clear();
      confirmNewPasswordController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update password: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style:
              AppStyles.headLineStyle2.copyWith(color: AppStyles.paletteBlack),
        ),
        backgroundColor: AppStyles.paletteDark,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              onPressed: logoutUser,
              style: AppStyles.redButton,
              child: const Text('Sign Out'),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //--Change Profile Picture--
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Change Profile Picture',
                style: AppStyles.headLineStyle2
                    .copyWith(color: AppStyles.blackColor),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppStyles.greyBgColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  ClipOval(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _image != null
                              ? MemoryImage(_image!)
                              : const AssetImage(AppMedia.profileIcon),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _pickImageFromGallery,
                        style: AppStyles.lightButton,
                        child: const Text('Add Photo'),
                      ),
                      ElevatedButton(
                        onPressed: _pickImageFromCamera,
                        style: AppStyles.lightButton,
                        child: const Text('Take Photo'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle confirm logic for the profile picture
                    },
                    style: AppStyles.darkButton,
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ),
            //--Change Default Address--
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Change Default Address',
                style: AppStyles.headLineStyle2
                    .copyWith(color: AppStyles.blackColor),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppStyles.greyBgColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      labelText: 'Default Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _updateAddress,
                    style: AppStyles.darkButton,
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ),
            //--Change Password & Delete Account--
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Change Password',
                style: AppStyles.headLineStyle2
                    .copyWith(color: AppStyles.blackColor),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppStyles.greyBgColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: currentPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Current Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: confirmNewPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm New Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _changePassword,
                    style: AppStyles.darkButton,
                    child: const Text('Confirm'),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle delete account logic
                    },
                    style: AppStyles.redButton,
                    child: const Text('Delete Account'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
  }

  Future<void> _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
  }
}
