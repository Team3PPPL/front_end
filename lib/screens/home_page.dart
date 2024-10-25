import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pppl_apps/components/all_data_students_ui.dart';
import 'package:pppl_apps/components/split_data_students_ui.dart';
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
                    borderRadius: BorderRadius.circular(10)),
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
          AllDataStudentsUI(totalSiswa: 246),

          const SizedBox(height: 20),

          // FIELD JUMLAH SISWA BERDASARKAN JENIS KELAMIN
          SplitDataStudentsUI(
            jmlhSiswaLaki: 100,
            jmlhSiswaPr: 146,
          ),

          const SizedBox(
            height: 50,
          ),

          // TANGGAL PERIODE KEUANGAN
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.8,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
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
