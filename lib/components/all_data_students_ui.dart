import 'package:flutter/material.dart';
import 'package:pppl_apps/constant/appFont.dart';

class AllDataStudentsUI extends StatefulWidget {
  int totalSiswa;
  AllDataStudentsUI({super.key, required this.totalSiswa});

  @override
  State<AllDataStudentsUI> createState() => _AllDataStudentsUIState();
}

class _AllDataStudentsUIState extends State<AllDataStudentsUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
      child: Stack(
        children: [
          // OBJECT ABSTRACT 1
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              "assets/object.png",
              height: MediaQuery.of(context).size.height / 11,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(180 / 360),
              child: Image.asset(
                "assets/object.png",
                height: MediaQuery.of(context).size.height / 11,
              ),
            ),
          ),

          // MAIN UI
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Siswa",
                  style: titleFonts,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${widget.totalSiswa}",
                  style: titleFonts,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
