import 'package:flutter/material.dart';
import 'package:pppl_apps/constant/appFont.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
                  aspectRatio: 16 / 9, child: Image.asset("assets/logo.jpg")),
              const SizedBox(
                height: 10,
              ),

              // NAMA APLIKASI
              Text(
                "NAMA APLIKASI",
                style: titleFonts,
              )
            ],
          ),
        ));
  }
}
