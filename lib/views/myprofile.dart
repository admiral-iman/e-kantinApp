import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'edit_profile.dart';

class MyProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    // Memeriksa argumen dan memperbarui profil ketika halaman dibuka
    final arguments = Get.arguments;

    if (arguments != null) {
      profileController.updateProfile(
        arguments['name'] ?? '',
        arguments['email'] ?? '',
        arguments['dob'] ?? '',
        arguments['gender'] ?? '',
        arguments['profileImage'] ?? '',
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                      image: profileController.profileImage.value.isNotEmpty
                          ? DecorationImage(
                              image: FileImage(
                                  File(profileController.profileImage.value)),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: AssetImage('assets/checkered_profile.png'),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 30),
            _buildProfileItem('Name', profileController.name.value),
            _buildProfileItem('Email', profileController.email.value),
            _buildProfileItem(
                'Date of Birth', profileController.dateOfBirth.value),
            _buildProfileItem('Gender', profileController.gender.value),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => EditProfilePage());
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          title: Text(
            value,
            style: TextStyle(fontSize: 14),
          ),
          trailing: Icon(Icons.chevron_right),
        ),
        Divider(),
      ],
    );
  }
}
