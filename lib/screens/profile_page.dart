import 'package:flutter/material.dart';
import 'package:pppl_apps/components/list_rekapitulasi_ui.dart';
import 'package:pppl_apps/constant/about_us_content.dart';
import 'package:pppl_apps/constant/appFont.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
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
              ),
            ),
          ),

          // NAMA MITRA
          Text(
            "Perguruan Tansyitul Muta'allimin",
            style: titleFonts,
            textAlign: TextAlign.center,
          ),
          const Divider(
            color: Colors.black,
            thickness: 2,
          ),
          Text(
            aboutUs,
            style: universalFonts,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),

          // UI REKAPITULASI MITRA
          const ListRekapitulasiUI(),
        ],
      ),
    );
  }
}
