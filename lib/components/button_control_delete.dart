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
      // MENAMPILKAN ALERT DIALOG BERNUANSA IOS
      return showCupertinoDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              // BAGIAN ATAS ALERT DIALOG
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
                  )
                ],
              ),

              // ISI DARI ALERT DIALOG
              content: Column(
                children: [
                  const Divider(
                    color: Colors.black,
                  ),
                  Text(
                      "Apakah anda ingin menghapus data $jenisData dari database?",
                      style: universalFonts),
                ],
              ),

              // OPSI PADA ALERT DIALOG
              actions: [
                CupertinoDialogAction(
                  child: Text(
                    "TIDAK",
                    style: boldComponentFonts,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                CupertinoDialogAction(
                  child: Text("YA", style: boldComponentFonts),
                  onPressed: () async {
                    await apiMethod();
                    refreshData();
                    Get.back();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: universalColors,
                        content: Text(
                          "DATA ${jenisData.toUpperCase()} BERHASIL DIHAPUS",
                          style: boldComponentFonts,
                        ),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  },
                )
              ],
            );
          });
    },
  );
}
