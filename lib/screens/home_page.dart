import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TANGGAL APLIKASI DIGUNAKAN
              Container(
                width: MediaQuery.of(context).size.width / 2.8,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    DateFormat("d MMMM yyyy").format(DateTime.now()),
                    style: titleFonts,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // FIELD JUMLAH SISWA
          Container(
            height: MediaQuery.of(context).size.height / 10,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15)),
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
                  "246",
                  style: titleFonts,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
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
                            "100",
                            style: titleFonts,
                          ),
                        ],
                      ),
                    ),
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
                            "146",
                            style: titleFonts,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 50,
          ),

          // TANGGAL PERIODE KEUANGAN
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.8,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Periode: 19 Oktober 2024",
                    style: titleFonts,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Divider(
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
