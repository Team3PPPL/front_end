import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';

buttonDirection(
    String jenisButton, dynamic direction, Function refreshData, context) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: GestureDetector(
      child: Container(
        height: MediaQuery.of(context).size.width / 8,
        width: MediaQuery.of(context).size.width / 3.5,
        decoration: BoxDecoration(
            color: componentColors, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          jenisButton,
          style: whiteComponentFonts,
        )),
      ),
      onTap: () async {
        Get.to(direction)!.then((result) {
          if (result == true) {
            refreshData();
          }
        });
      },
    ),
  );
}
