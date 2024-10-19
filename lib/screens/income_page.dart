import 'package:flutter/material.dart';
import 'package:pppl_apps/constant/appFont.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "INI ADALAH HALAMAN PEMASUKAN",
          style: universalFonts,
        ),
      ),
    );
  }
}
