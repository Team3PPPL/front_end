import 'package:flutter/material.dart';
import 'package:pppl_apps/components/button_print.dart';
import 'package:pppl_apps/components/format_currency_string.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/models/pemasukan_model.dart';
import 'package:pppl_apps/services/pemasukan_services.dart';

class DetailIncomePage extends StatelessWidget {
  PemasukanModel pemasukanModel;
  DetailIncomePage({super.key, required this.pemasukanModel});

  @override
  Widget build(BuildContext context) {
    final getData = pemasukanModel;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: componentColors,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child:
                        // MENAMPILKAN PERIODE KEUANGAN DARI DATA YANG DIPILIH
                        Column(
                      children: [
                        Text(
                          "Laporan Pemasukan",
                          style: whiteTitleFonts,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Periode: ${getData.tanggalPemasukan.year} / ${getData.tanggalPemasukan.year + 1}",
                          style: whiteBoldComponentFonts,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                // MENAMPILKAN SELURUH DATA PEMASUKAN DARI DATA YANG TELAH DIPILIH
                DataTable(
                    border: TableBorder.all(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(17)),
                    // MENGENERATE ITEM YANG AKAN DITAMPILKAN PADA HEADERS TABEL
                    columns: [
                      DataColumn(
                          label: Center(
                              child: Text(
                        "Keterangan",
                        style: boldComponentFonts,
                      ))),
                      DataColumn(
                          label: Text(
                        "Nominal",
                        style: boldComponentFonts,
                      )),
                    ],

                    // MENAMPILKAN SELURUH ITEM DALAM BENTUK TABEL
                    rows: [
                      rowOfTable("Bos", "${getData.bos}"),
                      rowOfTable("Kelas 1", "${getData.kelas1}"),
                      rowOfTable("Kelas 2", "${getData.kelas2}"),
                      rowOfTable("Kelas 3", "${getData.kelas3}"),
                      rowOfTable("Kelas 4", "${getData.kelas4}"),
                      rowOfTable("Kelas 5", "${getData.kelas5}"),
                      rowOfTable("Kelas 6", "${getData.kelas6}"),
                      rowOfTable("Total", "3000000"),
                    ]),
                const SizedBox(
                  height: 50,
                ),
                buttonPrint(
                    () async => await PemasukanServices().printData(getData.id),
                    context)
              ],
            ),
          ),
        ));
  }

  // FUNCTION UNTUK MENGENERATE ITEM TABEL SATU PER SATU
  rowOfTable(String keterangan, String nominal) {
    return DataRow(cells: [
      DataCell(Text(
        keterangan,
        style: universalFonts,
      )),
      DataCell(Text(
        formatCurrencyString(nominal),
        style: universalFonts,
      )),
    ]);
  }
}
