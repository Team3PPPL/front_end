import 'package:flutter/material.dart';
import 'package:pppl_apps/constant/appFont.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "INI ADALAH HALAMAN PROFILE",
          style: universalFonts,
        ),
      ),
    );
  }
}
