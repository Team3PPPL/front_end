import 'package:flutter/material.dart';
import 'package:pppl_apps/components/list_rekapitulasi_ui.dart';
import 'package:pppl_apps/constant/about_us_content.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String pathImage = "assets/logo.png";

  @override
  void initState() {
    loadImage();
    super.initState();
  }

  Future<void> loadImage() async {
    await precacheImage(AssetImage(pathImage), context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                              pathImage,
                              fit: BoxFit.contain,
                            ))),

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

                // DESKRIPSI SINGKAT MITRA
                Text(
                  aboutUs,
                  style: universalFonts,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        // UI REKAPITULASI MITRA
        const ListRekapitulasiUI(),
      ],
    );
  }
}
