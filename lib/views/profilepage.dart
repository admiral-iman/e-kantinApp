// profile_page.dart
import 'package:flutter/material.dart';
import 'myprofile.dart'; // Pastikan ini sudah benar

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
                image: DecorationImage(
                  image: AssetImage('assets/checkered_profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Katty Berry',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'kattyberry@gmail.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 30),
          _buildMenuItem(context, Icons.person, 'My Profile', () {
            // Navigasi ke MyProfilePage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyProfilePage()),
            );
          }),
          _buildMenuItem(context, Icons.shopping_bag, 'My Orders', () {
            // Handle My Orders tap
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.orange[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.orange),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
