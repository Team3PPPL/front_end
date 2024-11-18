import 'package:flutter/material.dart';
import 'package:pppl_apps/components/button_control_delete.dart';
import 'package:pppl_apps/components/button_controller_direction.dart';
import 'package:pppl_apps/components/button_text_direction.dart';
import 'package:pppl_apps/components/format_currency_string.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/models/pemasukan_model.dart';
import 'package:pppl_apps/screens/cash%20in/cash_in_page.dart';
import 'package:pppl_apps/screens/cash%20in/detail_income_page.dart';
import 'package:pppl_apps/screens/cash%20in/edit_cash_in_page.dart';
import 'package:pppl_apps/services/pemasukan_services.dart';
import 'package:pppl_apps/services/total_pemasukan_service.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  late Future<List<PemasukanModel>> newDataPemasukan;
  late Future<Map<String, dynamic>> newDataTotal;
  final PemasukanServices pemasukanServices = PemasukanServices();
  final TotalPemasukanService totalPemasukanService = TotalPemasukanService();

  @override
  void initState() {
    super.initState();
    newDataPemasukan = pemasukanServices.getAllDataPemasukan();
    newDataTotal = totalPemasukanService.getAllDataTotalPemasukan();
  }

  // FUNCTION UNTUK MEMPERBARUI DATA SETIAP ADA PERUBAHAN YANG TERJADI
  void refreshData() async {
    await PemasukanServices().getAllDataPemasukan();
    await TotalPemasukanService().getAllDataTotalPemasukan();
    setState(() {
      newDataPemasukan = pemasukanServices.getAllDataPemasukan();
      newDataTotal = totalPemasukanService.getAllDataTotalPemasukan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: componentColors,
        title: Text(
          "PEMASUKAN",
          style: whiteTitleFonts,
        ),
        centerTitle: true,
      ),
      body:
          // BASE DETAIL PEMASUKAN
          Column(
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
                      style: universalFonts,
                    ),
                    Text("Cash In", style: universalFonts),
                  ],
                ),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 15),
              height: MediaQuery.of(context).size.height / 1.75,
              child:
                  // BASE LIST DATA PEMASUKAN YANG TELAH DIINPUT
                  FutureBuilder(
                future: newDataPemasukan,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData) {
                    return Center(
                        child: Text(
                      "Ooops, belum ada data yang tersimpan dalam database",
                      style: universalFonts,
                    ));
                  } else {
                    final getAllData = snapshot.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: getAllData!.length,
                      itemBuilder: (context, index) {
                        final getData = getAllData[index];
                        final totalPemasukanIndex = getData.bos +
                            getData.kelas1 +
                            getData.kelas2 +
                            getData.kelas3 +
                            getData.kelas4 +
                            getData.kelas5 +
                            getData.kelas6;
                        return Column(
                          children: [
                            // BASE DARI SETIAP DATA PEMASUKAN YANG DIINPUT
                            Container(
                              color: universalColors,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          "+ ${formatCurrencyString("$totalPemasukanIndex")}",
                                          style: universalFonts,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        // MENAMPILKAN ID DARI SETIAP DATA
                                        Text(
                                          "${getData.id}",
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
                                        buttonControlDelete(
                                          Icons.delete_forever,
                                          () async => await PemasukanServices()
                                              .deleteDataPemasukan(getData.id),
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
                                              pemasukanModel: getData,
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
                      },
                    );
                  }
                },
              )),

          // BUTTON UNTUK MENGINPUT DATA PEMASUKAN
          buttonDirection(
              "Cash In", const CashInPage(), () => refreshData(), context)
        ],
      ),
      bottomSheet: FutureBuilder(
        future: newDataTotal,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData) {
            return baseTotalPemasukan(context, "--");
          } else {
            final getDataTotal = snapshot.data;
            return baseTotalPemasukan(context, getDataTotal?["totalAllIds"]);
          }
        },
      ),
    );
  }

  // FUNCTION UNTUK BASE UI DARI TOTAL PEMASUKAN
  Padding baseTotalPemasukan(BuildContext context, String baseText) {
    return Padding(
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
                style: whiteUniversalFonts,
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
                    baseText.replaceAll(',00', ''),
                    style: universalFonts,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
