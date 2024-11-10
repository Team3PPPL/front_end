import 'package:flutter/material.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';

buttonSave(String text, context) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      height: MediaQuery.of(context).size.width / 8,
      width: MediaQuery.of(context).size.width / 3.5,
      decoration: BoxDecoration(
          color: componentColors, borderRadius: BorderRadius.circular(20)),
      child: Center(
          child: Text(
        text,
        style: whiteBoldComponentFonts,
      )),
    ),
  );
}
