import 'package:flutter/material.dart';
import 'package:pppl_apps/components/button_control_delete_decade.dart';
import 'package:pppl_apps/components/button_control_direction.dart';
import 'package:pppl_apps/components/button_text_direction.dart';
import 'package:pppl_apps/components/empty_data.dart';
import 'package:pppl_apps/components/format_currency_string.dart';
import 'package:pppl_apps/constant/app_color.dart';
import 'package:pppl_apps/constant/app_font.dart';
import 'package:pppl_apps/models/income_model.dart';
import 'package:pppl_apps/screens/cash%20in/cash_in_page.dart';
import 'package:pppl_apps/screens/cash%20in/detail_income_page.dart';
import 'package:pppl_apps/screens/cash%20in/edit_cash_in_page.dart';
import 'package:pppl_apps/services/income_services.dart';
import 'package:pppl_apps/services/total_income_service.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  late Future<List<IncomeModel>> newDataIncome;
  late Future<Map<String, dynamic>> newTotalDataIncome;
  final IncomeServices incomeServices = IncomeServices();
  final TotalIncomeServices totalIncomeService = TotalIncomeServices();

  @override
  void initState() {
    super.initState();
    newDataIncome = incomeServices.getAllDataIncome();
    newTotalDataIncome = totalIncomeService.getAllDataTotalIncome();
  }

  // FUNCTION UNTUK MEMPERBARUI DATA SETIAP ADA PERUBAHAN YANG TERJADI
  void refreshData() async {
    await IncomeServices().getAllDataIncome();
    await TotalIncomeServices().getAllDataTotalIncome();
    setState(() {
      newDataIncome = incomeServices.getAllDataIncome();
      newTotalDataIncome = totalIncomeService.getAllDataTotalIncome();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: componentColors,
        title: Text(
          "PEMASUKAN",
          style: whiteTitleFonts,
        ),
        centerTitle: true,
      ),

      // BASE DETAIL PEMASUKAN
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Container(
              color: universalColors,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nama / Keterangan",
                      style: boldComponentFonts,
                    ),
                    Text("Cash In", style: universalFonts),
                  ],
                ),
              ),
            ),
          ),

          // BASE LIST DATA PEMASUKAN YANG TELAH DIINPUT
          Container(
              margin: const EdgeInsets.only(bottom: 15),
              height: MediaQuery.of(context).size.height / 1.68,
              child: FutureBuilder(
                future: newDataIncome,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: componentColors,
                    ));
                  } else if (snapshot.hasError) {
                    return Text(
                      "Error: ${snapshot.error}",
                      style: universalFonts,
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return emptyDataAnnounce(context);
                  } else {
                    final getAllData = snapshot.data;
                    getAllData!.sort((a, b) => b.id.compareTo(a
                        .id)); // MENGURUTKAN DATA BERDASARKAN ID YANG PALING TERAKHIR YANG MASUK KE DATABASE

                    // CONTAINER YANG BERISIKAN DATA DARI DATABASE
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: getAllData.length,
                        itemBuilder: (context, index) {
                          final getData = getAllData[index];
                          return FutureBuilder(
                            future: totalIncomeService
                                .getAllDataTotalIncomeByDecadeID(getData.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  !snapshot.hasData) {
                                return baseListIncome(getData, "0", "0");
                              } else {
                                final getTotalIncome = snapshot.data;
                                return baseListIncome(
                                    getData,
                                    "${getTotalIncome!["totalPemasukan"]}",
                                    getTotalIncome);
                              }
                            },
                          );
                        });
                  }
                },
              )),

          // TOMBOL CASH IN UNTUK MENGINPUT DATA BARU
          buttonDirection(
              "Cash In", const CashInPage(), () => refreshData(), context),
          const SizedBox(
            height: 10,
          ),

          // BASE TOTAL PEMASUKAN DARI SELURUH PERIODE
          FutureBuilder(
            future: newTotalDataIncome,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else if (!snapshot.hasData) {
                return baseTotalIncome(context, "--");
              } else {
                final getDataTotal = snapshot.data;
                return baseTotalIncome(
                    context, "${getDataTotal!["totalPemasukan"]}");
              }
            },
          ),
        ],
      ),
    );
  }

  // FUNCTION UNTUK BASE UI DARI LIST PEMASUKAN
  Column baseListIncome(
      IncomeModel getData, String totalPemasukan, getTotalIncome) {
    // BASE DARI SETIAP DATA PEMASUKAN YANG DIINPUT
    return Column(
      children: [
        Container(
          color: universalColors,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // MENAMPILKAN PERIODE DATA PEMASUKAN
                    Text(
                      "Periode: ${getData.tanggalPemasukan.year} / ${getData.tanggalPemasukan.year + 1}",
                      style: boldComponentFonts,
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                    // MENAMPILKAN TOTAL PEMASUKAN YANG DITERIMA DALAM 1 PERIODE
                    Text(
                      "+ ${formatCurrencyString(totalPemasukan)}",
                      style: universalFonts,
                    ),
                  ],
                ),

                // ICON EDIT DAN DELETE DATA PEMASUKAN
                Row(
                  children: [
                    // BUTTON EDIT DATA PEMASUKAN BERDASARKAN INDEX
                    buttonControlDirection(
                        Icons.edit,
                        EditCashInPage(
                          pemasukanModel: getData,
                        ),
                        () => refreshData(),
                        context),

                    const SizedBox(
                      width: 10,
                    ),

                    // BUTTON HAPUS DATA PEMASUKAN BERDASARKAN ID
                    buttonControlDeleteDecade(
                      Icons.delete_forever,
                      () async =>
                          await incomeServices.deleteDataIncomeById(getData.id),
                      '${getData.tanggalPemasukan.year} / ${getData.tanggalPemasukan.year + 1}',
                      () => refreshData(),
                      context,
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    // BUTTON DETAIL DATA PEMASUKAN BERDASARKAN INDEX
                    buttonControlDirection(
                        Icons.info_outline,
                        DetailIncomePage(
                          incomeModel: getData,
                          totalIncome: getTotalIncome,
                        ),
                        () => refreshData(),
                        context),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }

  // FUNCTION UNTUK BASE UI DARI TOTAL PEMASUKAN
  Align baseTotalIncome(BuildContext context, String baseText) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          height: MediaQuery.of(context).size.height / 10,
          width: double.infinity,
          color: componentColors,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Total Cash In",
                  style: whiteBoldComponentFonts,
                ),
                const SizedBox(
                  height: 8,
                ),

                // CONTAINER UNTUK MENAMPILKAN TOTAL DATA PEMASUKAN
                Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      formatCurrencyString(baseText),
                      style: universalFonts,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
