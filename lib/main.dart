import 'package:e_kantin/views/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart'; // Untuk mendapatkan direktori penyimpanan
import 'package:get/get.dart';
import 'controllers/profile_controller.dart'; // Import GetX
import 'views/createprofile.dart'; // Import CreateProfilePage
import 'views/myprofile.dart'; // Import MyProfilePage

void main() async {
  Get.put(ProfileController());

  WidgetsFlutterBinding.ensureInitialized();

  // Mendapatkan direktori penyimpanan aplikasi
  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  // Inisialisasi Hive dengan path penyimpanan
  Hive.init(appDocumentDirectory.path);

  // Membuka box 'login' dan 'accounts'
  await Hive.openBox('login');
  await Hive.openBox('accounts');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFE724C)),
        useMaterial3: true,
      ),
      initialRoute: '/', // Rute awal aplikasi
      getPages: [
        GetPage(
            name: '/',
            page: () => SplashPage()), // Ganti dengan halaman splash Anda
        GetPage(
            name: '/createProfile',
            page: () => CreateProfilePage()), // Rute untuk CreateProfilePage
        GetPage(
            name: '/myProfile',
            page: () => MyProfilePage()), // Rute untuk MyProfilePage
      ],
    );
  }
}
