import 'package:flutter/material.dart';
import 'package:pppl_apps/constant/appColor.dart';

buttonControl(iconButton, context) {
  return Container(
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
  );
}
