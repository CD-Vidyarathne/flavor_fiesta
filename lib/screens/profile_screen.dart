import 'package:flavor_fiesta/core/res/media/app_media.dart';
import 'package:flavor_fiesta/core/res/routes/app_routes.dart';
import 'package:flavor_fiesta/core/res/styles/app_styles.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppMedia.profileIcon),
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
                          // Handle add photo logic
                        },
                        style: AppStyles.lightButton,
                        child: const Text('Add Photo'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle take photo logic
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
                  const TextField(
                    decoration: InputDecoration(
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
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Current Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
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
}
