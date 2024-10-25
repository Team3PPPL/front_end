import 'package:flutter/material.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';

class SplitDataStudentsUI extends StatefulWidget {
  int jmlhSiswaLaki;
  int jmlhSiswaPr;

  SplitDataStudentsUI(
      {super.key, required this.jmlhSiswaLaki, required this.jmlhSiswaPr});

  @override
  State<SplitDataStudentsUI> createState() => _SplitDataStudentsUIState();
}

class _SplitDataStudentsUIState extends State<SplitDataStudentsUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 13,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      child: IntrinsicHeight(
        // OBJECT ABSTRACT 2
        child: Stack(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.only(topLeft: Radius.circular(10)),
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/object2.png",
                  height: MediaQuery.of(context).size.height / 30,
                ),
              ),
            ),
            ClipRRect(
              borderRadius:
                  const BorderRadius.only(bottomRight: Radius.circular(10)),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(180 / 360),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    "assets/object2.png",
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  // FIELD JUMLAH SISWA LAKI-LAKI
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Siswa Laki-Laki",
                          style: titleFonts,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${widget.jmlhSiswaLaki}",
                          style: titleFonts,
                        ),
                      ],
                    ),
                  ),

                  // GARIS PEMBATAS SECARA VERTIKAL (HARUS MENGGUNAKAN INTRINSICHEIGHT)
                  const VerticalDivider(
                    color: universalColors,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),

                  // FIELD JUMLAH SISWA PEREMPUAN
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Siswa Perempuan",
                          style: titleFonts,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${widget.jmlhSiswaPr}",
                          style: titleFonts,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
