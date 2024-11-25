import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pppl_apps/components/all_data_students_ui.dart';
import 'package:pppl_apps/components/format_currency_string.dart';
import 'package:pppl_apps/components/split_data_students_ui.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/services/total_pemasukan_service.dart';
import 'package:pppl_apps/services/total_pengeluaran_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting("id", null);
  }

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'id';
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CONTAINER UNTUK MENAMPILKAN TANGGAL SAAT INI
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    DateFormat("d MMMM yyyy", "id").format(DateTime.now()),
                    style: titleFonts,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // CONTAINER TOTAL SISWA
          AllDataStudentsUI(totalSiswa: 246),

          const SizedBox(height: 20),

          // CONTAINER JUMLAH SISWA BERDASARKAN JENIS KELAMIN
          SplitDataStudentsUI(
            jmlhSiswaLaki: 100,
            jmlhSiswaPr: 146,
          ),

          const SizedBox(
            height: 50,
          ),

          // CONTAINER TANGGAL PERIODE KEUANGAN
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    "Periode: 19 September 2024",
                    style: titleFonts,
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
          ),

          // BASE CONTAINER FINANCE
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Kas",
                  style: titleFonts,
                ),
                const SizedBox(
                  height: 30,
                ),

                // BASE CONTAINER MENAMPILKAN TOTAL PEMASUKAN DAN PENGELUARAN
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // BASE CONTAINER PEMASUKAN
                    monitoredPemasukan(),

                    // BASE CONTAINER PENGELUARAN
                    monitoredPengeluaran()
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // FUNCTION UNTUK MEMONITOR DATA PEMASUKAN YANG DIINPUT
  FutureBuilder<Map<String, dynamic>> monitoredPemasukan() {
    return FutureBuilder(
      future: TotalPemasukanService().getAllDataTotalPemasukan(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return baseFinancePemasukan("0");
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          final getData = snapshot.data;
          return baseFinancePemasukan("${getData!["totalPemasukan"]}");
        }
      },
    );
  }

  // FUNCTION UNTUK MEMONITOR DATA PENGELUARAN YANG DIINPUT
  FutureBuilder<Map<String, dynamic>> monitoredPengeluaran() {
    return FutureBuilder(
      future: TotalPengeluaranService().getAllDataTotalPengeluaran(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return baseFinancePengeluaran("0");
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          final getData = snapshot.data;
          return baseFinancePengeluaran("${getData!["totalPengeluaran"]}");
        }
      },
    );
  }

  // BASE CONTAINER TOTAL PEMASUKAN
  Column baseFinancePemasukan(String totalPemasukan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 13,
              backgroundColor: Colors.red[200],
              child: Icon(
                Icons.arrow_upward,
                color: Colors.red[800],
                size: 19,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Pemasukan",
              style: boldComponentFonts,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 37),
          child: Center(
            child: Text(
              formatCurrencyString(totalPemasukan),
              style: smallUniversalFonts,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  // BASE CONTAINER TOTAL PEMASUKAN
  Column baseFinancePengeluaran(String totalPengeluaran) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 13,
              backgroundColor: universalColors,
              child: Icon(
                Icons.arrow_downward,
                color: componentColors,
                size: 19,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Pengeluaran",
              style: boldComponentFonts,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 37),
          child: Center(
            child: Text(
              formatCurrencyString(totalPengeluaran),
              style: smallUniversalFonts,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
