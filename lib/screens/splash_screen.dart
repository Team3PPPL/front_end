import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pppl_apps/constant/app_font.dart';
import 'package:pppl_apps/services/firebase/auth_gate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToLoginPage();
  }

  // FUNCTION UNTUK NAVIGASI KE HALAMAN SELANJUTNYA
  Future navigateToLoginPage() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    Get.off(const AuthGate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LOGO APLIKASI
              Image.asset(
                "assets/logo.png",
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width / 2,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 50,
              ),

              // NAMA APLIKASI
              Text(
                "TANSYITUL FINANSIAL MANAGEMENT",
                style: titleFonts,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }
}
