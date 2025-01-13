import 'package:flutter/material.dart';
import 'package:pppl_apps/components/list_rekapitulasi_ui.dart';
import 'package:pppl_apps/constant/about_us_content.dart';
import 'package:pppl_apps/constant/app_color.dart';
import 'package:pppl_apps/constant/app_font.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          color: componentColors,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 15),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/logo.png",
                      height: MediaQuery.of(context).size.width / 2.5,
                      width: MediaQuery.of(context).size.width / 2.5,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Tansyitul Muta'allimin",
                    style: whiteTitleFonts,
                    textAlign: TextAlign.center,
                  ),
                  const Divider(color: Colors.white, thickness: 2),
                  Text(
                    aboutUs,
                    style: whiteUniversalFonts,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        const ListRekapitulasiUI(),
      ],
    );
  }
}
