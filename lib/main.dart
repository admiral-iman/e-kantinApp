import 'package:e_kantin/views/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart'; // Untuk mendapatkan direktori penyimpanan

void main() async {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFE724C)),
        useMaterial3: true,
      ),
      home: const SplashPage(), // Start dengan halaman login
    );
  }
}
