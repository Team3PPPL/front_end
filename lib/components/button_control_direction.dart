import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pppl_apps/constant/appColor.dart';

buttonControlDirection(iconButton, direction, Function refreshMethod, context) {
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
        )),
      ),
    ),
    onTap: () async {
      await Get.to(direction)!.then((result) {
        if (result == true) {
          refreshMethod();
        }
      });
    },
  );
}
