import 'dart:io';
import 'dart:typed_data';
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
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  Uint8List? _image;
  File? selectedImage;

  @override
  void dispose() {
    _addressController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
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
              onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
              style: AppStyles.redButton,
              child: const Text('Sign Out'),
            ),
          ),
        ],
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
                        onPressed: () {
                          _pickImageFromGallery();
                        },
                        style: AppStyles.lightButton,
                        child: const Text('Add Photo'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _pickImageFromCamera();
                        },
                        style: AppStyles.lightButton,
                        child: const Text('Take Photo'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle confirm logic
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
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Default Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle confirm logic
                    },
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
                    controller: _currentPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Current Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _confirmNewPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm New Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle confirm logic
                    },
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

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
  }

  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
  }
}
