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
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      child: IntrinsicHeight(
        // OBJECT ABSTRACT 2 KIRI ATAS
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(10)),
                child: Image.asset(
                  "assets/object2.png",
                  height: MediaQuery.of(context).size.height / 25,
                ),
              ),
            ),

            // OBJECT ABSTRACT 2 KANAN BAWAH
            RotationTransition(
              turns: const AlwaysStoppedAnimation(180 / 360),
              child: Align(
                alignment: Alignment.topLeft,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(bottomRight: Radius.circular(10)),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(10)),
                    child: Image.asset(
                      "assets/object2.png",
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  // CONTAINER JUMLAH SISWA LAKI-LAKI
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Siswa Laki-Laki",
                            style: titleFonts, textAlign: TextAlign.center),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("${widget.jmlhSiswaLaki}",
                            style: titleFonts, textAlign: TextAlign.center),
                      ],
                    ),
                  ),

                  // GARIS PEMBATAS SECARA VERTIKAL (HARUS MENGGUNAKAN WIDGET INTRINSICHEIGHT)
                  const VerticalDivider(
                    color: componentColors,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),

                  // CONTAINER JUMLAH SISWA PEREMPUAN
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Siswa Perempuan",
                            style: titleFonts, textAlign: TextAlign.center),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("${widget.jmlhSiswaPr}",
                            style: titleFonts, textAlign: TextAlign.center),
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
