import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pppl_apps/constant/app_font.dart';

emptyDataAnnounce(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.network(
        height: MediaQuery.of(context).size.height / 5,
        "https://lottie.host/19da9623-d016-47de-9398-07c8d8e0c2c6/dp8Anee5bJ.json",
        repeat: false,
        fit: BoxFit.cover,
      ),
      Text(
        "No Data Found !",
        style: titleFonts,
      ),
      Text(
        "Belum ada data yang tersimpan dalam database",
        style: universalFonts,
      )
    ],
  );
}
