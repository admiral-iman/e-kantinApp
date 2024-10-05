import 'dart:io'; // Import this to use File
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'homepage.dart'; // Import halaman Home
import '../controllers/profile_controller.dart'; // Import controller untuk profil

class CreateProfilePage extends StatefulWidget {
  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String _gender = 'Male'; // Variabel untuk menyimpan gender yang dipilih
  File? _profileImage; // Variabel untuk menyimpan image file

  final ImagePicker _picker = ImagePicker(); // Instance of ImagePicker

  Future<void> _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // Set the profile image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                      image: _profileImage != null
                          ? DecorationImage(
                              image: FileImage(_profileImage!),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: AssetImage('assets/checkered_profile.png'),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: _pickImage, // Call the method to pick an image
                    child: Text('Change Photo'),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            _buildInputField('Full Name', _nameController),
            SizedBox(height: 16),
            _buildInputField('Email', _emailController),
            SizedBox(height: 16),
            _buildDateField(),
            SizedBox(height: 16),
            Text('Gender',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            _buildGenderSelection(),
            SizedBox(height: 32),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date of Birth',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // Logika pemilih tanggal
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            ).then((selectedDate) {
              if (selectedDate != null) {
                setState(() {
                  _dobController.text =
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"; // Update controller dengan tanggal yang dipilih
                });
              }
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              controller: _dobController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelection() {
    return Row(
      children: [
        Expanded(
          child: _buildGenderOption(
              'Male', _gender == 'Male'), // Cek apakah 'Male' dipilih
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildGenderOption(
              'Female', _gender == 'Female'), // Cek apakah 'Female' dipilih
        ),
      ],
    );
  }

  Widget _buildGenderOption(String gender, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _gender = gender; // Mengubah gender yang dipilih saat ditekan
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected)
              Icon(Icons.check_circle, color: Colors.white, size: 20)
            else
              Icon(Icons.circle_outlined, color: Colors.grey, size: 20),
            SizedBox(width: 8),
            Text(
              gender,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_profileImage != null &&
              _nameController.text.isNotEmpty &&
              _emailController.text.isNotEmpty) {
            // Ambil data dari controller dan kirim ke HomePage
            Get.to(() => Home(), arguments: {
              'name': _nameController.text,
              'email': _emailController.text,
              'dob': _dobController.text,
              'gender': _gender,
              'profileImage': _profileImage?.path ?? '',
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      'Please fill all fields and upload a profile image.')),
            );
          }
        },
        child: Text('Submit', style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          primary: Colors.orange,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
