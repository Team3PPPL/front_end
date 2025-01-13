import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pppl_apps/constant/app_color.dart';
import 'package:pppl_apps/constant/app_font.dart';

buttonControlDelete(iconButton, Function apiMethod, String jenisData,
    Function refreshData, context) {
  return GestureDetector(
    child: Container(
      width: MediaQuery.of(context).size.width / 10,
      decoration: BoxDecoration(
          color: componentColors, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Icon(
            iconButton,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    ),
    onTap: () async {
      // MENAMPILKAN ALERT DIALOG
      return showCupertinoDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.exclamationmark_circle,
                    color: Colors.red,
                    size: 70,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Apakah Anda Yakin ?",
                    style: titleFonts,
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                ],
              ),
              content: RichText(
                text: TextSpan(
                    text: "Apakah anda ingin menghapus data ",
                    style: universalFonts,
                    children: [
                      TextSpan(text: jenisData, style: boldUniversalFonts),
                      TextSpan(text: " dari database?", style: universalFonts)
                    ]),
                textAlign: TextAlign.center,
              ),

              // Text(
              //   "Apakah anda ingin menghapus seluruh data pada periode: $jenisData dari database?",
              //   style: universalFonts,
              //   textAlign: TextAlign.center,
              // ),
              actions: [
                MaterialButton(
                    child: Text("TIDAK", style: redBoldComponentFonts),
                    onPressed: () {
                      Get.back();
                    }),
                MaterialButton(
                  child: Text("YA", style: greenBoldComponentFonts),
                  onPressed: () async {
                    await apiMethod();
                    refreshData();
                    Get.back();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: universalColors,
                        content: Text(
                          "DATA PERIODE $jenisData BERHASIL DIHAPUS",
                          style: boldComponentFonts,
                        ),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  },
                ),
              ],
            );
          });
    },
  );
}
