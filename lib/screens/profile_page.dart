import 'package:flutter/material.dart';
import 'package:pppl_apps/components/list_rekapitulasi_ui.dart';
import 'package:pppl_apps/constant/about_us_content.dart';
import 'package:pppl_apps/constant/app_color.dart';
import 'package:pppl_apps/constant/app_font.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: componentColors,
        toolbarHeight: 0,
      ),
      body: ListView(
        children: [
          Container(
            color: componentColors,
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child:
                          // LOGO MITRA
                          AspectRatio(
                              aspectRatio: 16 / 5.5,
                              child: Image.asset(
                                "assets/logo.png",
                                fit: BoxFit.contain,
                              ))),

                  // NAMA MITRA
                  Text(
                    "Tansyitul Muta'allimin",
                    style: whiteTitleFonts,
                    textAlign: TextAlign.center,
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),

                  // DESKRIPSI SINGKAT MITRA
                  Text(
                    aboutUs,
                    style: whiteUniversalFonts,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // UI REKAPITULASI MITRA
          const ListRekapitulasiUI(),
        ],
      ),
    );
  }
}
