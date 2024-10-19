import 'package:flutter/material.dart';
import 'package:pppl_apps/constant/appFont.dart';

class OutcomePage extends StatelessWidget {
  const OutcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "INI ADALAH HALAMAN PENGELUARAN",
          style: universalFonts,
        ),
      ),
    );
  }
}
