import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pppl_apps/constant/app_color.dart';
import 'package:pppl_apps/constant/app_font.dart';

buttonDirection(
    String jenisButton, dynamic direction, Function refreshData, context) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                color: componentColors,
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 25),
              child: Text(
                jenisButton,
                style: whiteBoldComponentFonts,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          onTap: () {
            Get.to(direction)!.then((result) {
              if (result == true) {
                refreshData();
              }
            });
          },
        )),
  );
}
