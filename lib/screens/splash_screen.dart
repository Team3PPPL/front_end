import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pppl_apps/constant/appFont.dart';
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
              AspectRatio(
                  aspectRatio: 16 / 7, child: Image.asset("assets/logo.png")),
              const SizedBox(
                height: 50,
              ),

              // NAMA APLIKASI
              Text(
                "Tansyitul Muta'allimiin",
                style: titleFonts,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }
}
