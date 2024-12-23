import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pppl_apps/components/button_print.dart';
import 'package:pppl_apps/constant/app_color.dart';
import 'package:pppl_apps/constant/app_font.dart';
import 'package:pppl_apps/models/income_model.dart';
import 'package:pppl_apps/services/income_services.dart';

class DetailIncomePage extends StatelessWidget {
  IncomeModel incomeModel;
  dynamic totalIncome;
  DetailIncomePage(
      {super.key, required this.incomeModel, required this.totalIncome});

  String formatCurrency(String value) {
    final number =
        int.tryParse(value.replaceAll('.', '').replaceAll('.', '')) ?? 0;
    final format =
        NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
    return format.format(number);
  }

  @override
  Widget build(BuildContext context) {
    final getData = incomeModel;
    final getTotalIncome = totalIncome["totalPemasukan"];
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

                    // MENAMPILKAN PERIODE KEUANGAN DARI DATA YANG DIPILIH
                    child: Column(
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
                      rowOfTable("Bos", "${getData.bos}", context),
                      rowOfTable("Kelas 1", "${getData.kelas1}", context),
                      rowOfTable("Kelas 2", "${getData.kelas2}", context),
                      rowOfTable("Kelas 3", "${getData.kelas3}", context),
                      rowOfTable("Kelas 4", "${getData.kelas4}", context),
                      rowOfTable("Kelas 5", "${getData.kelas5}", context),
                      rowOfTable("Kelas 6", "${getData.kelas6}", context),
                      rowOfTable("Total Pemasukan", "$getTotalIncome", context),
                    ]),
                const SizedBox(
                  height: 50,
                ),

                // TOMBOL UNTUK MENCETAK DATA PEMASUKAN DALAM BENTUK PDF
                buttonPrint(
                    () async =>
                        await IncomeServices().printDataIncomeById(getData.id),
                    context)
              ],
            ),
          ),
        ));
  }

  // FUNCTION UNTUK MENGENERATE ITEM TABEL SATU PER SATU
  rowOfTable(String keterangan, String nominal, context) {
    return DataRow(cells: [
      DataCell(Text(
        keterangan,
        style: universalFonts,
        overflow: TextOverflow.clip,
      )),
      DataCell(Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Rp. ",
            style: universalFonts,
          ),
          Expanded(
            child: Text(
              formatCurrency(nominal),
              style: universalFonts,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      )),
    ]);
  }
}
