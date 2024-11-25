import 'package:flutter/material.dart';
import 'package:pppl_apps/components/button_controller_direction.dart';
import 'package:pppl_apps/components/button_text_direction.dart';
import 'package:pppl_apps/components/format_currency_string.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/models/pengeluaran_model.dart';
import 'package:pppl_apps/screens/cash%20out/cash_out_page.dart';
import 'package:pppl_apps/screens/cash%20out/edit_cash_out_page.dart';
import 'package:pppl_apps/services/pengeluaran_service.dart';
import 'package:pppl_apps/services/total_pengeluaran_service.dart';

class ListsPengeluaranInDecadePage extends StatefulWidget {
  PengeluaranModel pengeluaranModel;
  ListsPengeluaranInDecadePage({super.key, required this.pengeluaranModel});

  @override
  State<ListsPengeluaranInDecadePage> createState() =>
      _ListsPengeluaranInDecadePageState();
}

class _ListsPengeluaranInDecadePageState
    extends State<ListsPengeluaranInDecadePage> {
  late Future<List<PengeluaranModel>> newDataPengeluaran;
  late Future<Map<String, dynamic>> newDataTotal;
  final PengeluaranServices pengeluaranServices = PengeluaranServices();
  final TotalPengeluaranService totalPengeluaranService =
      TotalPengeluaranService();

  @override
  void initState() {
    super.initState();
    newDataPengeluaran = pengeluaranServices.getAllDataPengeluaran();
    newDataTotal = totalPengeluaranService
        .getAllDataTotalPengeluaranInDecade(widget.pengeluaranModel.id);
  }

  // FUNCTION UNTUK MEMPERBARUI DATA SETIAP ADA PERUBAHAN YANG TERJADI
  void refreshData() async {
    await PengeluaranServices().getAllDataPengeluaran();
    await TotalPengeluaranService()
        .getAllDataTotalPengeluaranInDecade(widget.pengeluaranModel.id);
    setState(() {
      newDataPengeluaran = pengeluaranServices.getAllDataPengeluaran();
      newDataTotal = totalPengeluaranService
          .getAllDataTotalPengeluaranInDecade(widget.pengeluaranModel.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: componentColors,
        title: Column(
          children: [
            Text(
              "DATA PENGELUARAN PERIODE",
              style: whiteTitleFonts,
            ),
            Text(
              "${widget.pengeluaranModel.decade.year} / ${widget.pengeluaranModel.decade.year + 1}",
              style: smallWhiteTitleFonts,
            ),
          ],
        ),
        centerTitle: true,
        leading: const Icon(
          Icons.keyboard_arrow_left_rounded,
          size: 35,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // TOMBOL UNTUK MENCETAK DATA PEMASUKAN DALAM BENTUK PDF
          IconButton(
              icon: const Icon(Icons.print),
              onPressed: () async {
                print(widget.pengeluaranModel.id);
                await PengeluaranServices()
                    .printData(widget.pengeluaranModel.id);
              })
        ],
      ),
      body:
          // BASE LIST PENGELUARAN
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
                    Text("Cash Out", style: universalFonts),
                  ],
                ),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 15),
              height: MediaQuery.of(context).size.height / 1.75,
              child:
                  // BASE LIST DATA PENGELUARAN YANG TELAH DIINPUT
                  FutureBuilder(
                      future: newDataPengeluaran,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text(
                            "Error: ${snapshot.error}",
                            style: universalFonts,
                          );
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
                              return Column(
                                children: [
                                  // BASE DARI SETIAP DATA PENGELUARAN YANG DIINPUT
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
                                              // DECADE PENGELUARAN DATA
                                              Text(
                                                "Periode: ${getData.decade.year} / ${getData.decade.year + 1}",
                                                style: boldComponentFonts,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "${getData.id}",
                                                style: universalFonts,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              // BUTTON DETAIL DATA PEMASUKAN BERDASARKAN INDEX
                                              buttonControlDirection(
                                                  Icons.edit,
                                                  EditCashOutPage(
                                                      pengeluaranModel:
                                                          getData),
                                                  () => refreshData(),
                                                  context),

                                              const SizedBox(
                                                width: 10,
                                              ),

                                              // BUTTON HAPUS SELURUH DATA PENGELUARAN BERDASARKAN DECADE
                                              // buttonControlDelete(
                                              //     Icons.delete_forever,
                                              //     () async =>
                                              //         await PengeluaranServices()
                                              //             .deleteAllDataPengeluaranInDecade(
                                              //                 getData.id),
                                              //     refreshData,
                                              //     context),
                                            ],
                                          ),
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
                      })),

          // BUTTON UNTUK MENGINPUT DATA PENGELUARAN
          buttonDirection(
              "Cash Out", const CashOutPage(), () => refreshData(), context)
        ],
      ),
      bottomSheet: FutureBuilder(
        future: newDataTotal,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return baseTotalPengeluaran(context, "--");
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            final getDataTotal = snapshot.data;
            return baseTotalPengeluaran(
                context, "${getDataTotal!["totalPengeluaran"]}");
          }
        },
      ),
    );
  }

  // FUNCTION UNTUK BASE UI DARI TOTAL PENGELUARAN
  Padding baseTotalPengeluaran(BuildContext context, String baseText) {
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
                    formatCurrencyString(baseText),
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
