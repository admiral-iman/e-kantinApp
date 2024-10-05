import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var dateOfBirth = ''.obs;
  var gender = ''.obs;
  var profileImage = ''.obs;

  void updateProfile(String name, String email, String dob, String gender,
      String profileImage) {
    this.name.value = name;
    this.email.value = email;
    this.dateOfBirth.value = dob;
    this.gender.value = gender;
    this.profileImage.value = profileImage; // Update gambar profil
  }
}
