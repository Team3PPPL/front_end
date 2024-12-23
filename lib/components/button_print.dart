import 'package:flutter/material.dart';
import 'package:pppl_apps/constant/app_color.dart';
import 'package:pppl_apps/constant/app_font.dart';

buttonPrint(Function apiMethod, context) {
  return GestureDetector(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.width / 8,
          width: MediaQuery.of(context).size.width / 3.5,
          decoration: BoxDecoration(
              color: componentColors, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Center(
                child: Text(
              "PRINT",
              style: whiteBoldComponentFonts,
            )),
          ),
        ),
      ),
      onTap: () async {
        await apiMethod();
      });
}
