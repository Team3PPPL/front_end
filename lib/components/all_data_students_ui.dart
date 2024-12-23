import 'package:flutter/material.dart';
import 'package:pppl_apps/constant/app_font.dart';

class AllDataStudentsUI extends StatefulWidget {
  int totalSiswa;
  AllDataStudentsUI({super.key, required this.totalSiswa});

  @override
  State<AllDataStudentsUI> createState() => _AllDataStudentsUIState();
}

class _AllDataStudentsUIState extends State<AllDataStudentsUI> {
  @override
  Widget build(BuildContext context) {
    // BASE REKAPITULASI TOTAL SISWA
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
      child: Stack(
        children: [
          // OBJECT ABSTRACT 1 KIRI BAWAH
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/object.png",
              height: MediaQuery.of(context).size.height / 15,
            ),
          ),

          // OBJECT ABSTRACT 1 KANAN ATAS
          Positioned(
            top: 0,
            right: 0,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(180 / 360),
              child: Image.asset(
                "assets/object.png",
                height: MediaQuery.of(context).size.height / 15,
              ),
            ),
          ),

          // CONTAINER TOTAL SISWA
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Siswa",
                    style: titleFonts,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${widget.totalSiswa}",
                    style: titleFonts,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
