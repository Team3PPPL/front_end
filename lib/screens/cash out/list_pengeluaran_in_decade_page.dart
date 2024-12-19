import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pppl_apps/components/button_control_delete.dart';
import 'package:pppl_apps/components/button_control_direction.dart';
import 'package:pppl_apps/components/button_text_direction.dart';
import 'package:pppl_apps/components/format_currency_string.dart';
import 'package:pppl_apps/components/format_date_string.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/models/outcome_model.dart';
import 'package:pppl_apps/screens/cash%20out/cash_out_page.dart';
import 'package:pppl_apps/screens/cash%20out/edit_cash_out_page.dart';
import 'package:pppl_apps/services/outcome_service.dart';
import 'package:pppl_apps/services/total_outcome_service.dart';

class ListsPengeluaranInDecadePage extends StatefulWidget {
  OutcomeModel outcomeModel;
  int indexData;
  ListsPengeluaranInDecadePage(
      {super.key, required this.outcomeModel, required this.indexData});

  @override
  State<ListsPengeluaranInDecadePage> createState() =>
      _ListsPengeluaranInDecadePageState();
}

class _ListsPengeluaranInDecadePageState
    extends State<ListsPengeluaranInDecadePage> {
  late Future<DataModel> newListDataOutcome;
  late Future<Map<String, dynamic>> newListTotalDataOutcome;
  final OutcomeServices outcomeServices = OutcomeServices();
  final TotalOutcomeServices totalOutcomeService = TotalOutcomeServices();

  @override
  void initState() {
    super.initState();
    newListDataOutcome = outcomeServices.getAllDataOutcomeByDecadeId(
        widget.outcomeModel.data![widget.indexData].id);
    newListTotalDataOutcome =
        totalOutcomeService.getAllDataTotalOutcomeByDecadeId(
            widget.outcomeModel.data![widget.indexData].id);
  }

  // FUNCTION UNTUK MEMPERBARUI DATA SETIAP ADA PERUBAHAN YANG TERJADI
  void refreshData() async {
    await OutcomeServices().getAllDataOutcome();
    await TotalOutcomeServices().getAllDataTotalOutcomeByDecadeId(
        widget.outcomeModel.data![widget.indexData].id);
    setState(() {
      newListDataOutcome = outcomeServices.getAllDataOutcomeByDecadeId(
          widget.outcomeModel.data![widget.indexData].id);
      newListTotalDataOutcome =
          totalOutcomeService.getAllDataTotalOutcomeByDecadeId(
              widget.outcomeModel.data![widget.indexData].id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDataOutcome = widget.outcomeModel.data![widget.indexData];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: componentColors,
        title: Column(
          children: [
            Text(
              "DATA PENGELUARAN",
              style: whiteTitleFonts,
            ),
            Text(
              "PERIODE: ${selectedDataOutcome.decade.year} / ${selectedDataOutcome.decade.year + 1}",
              style: smallWhiteTitleFonts,
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          iconSize: 35,
          icon: const Icon(Icons.keyboard_arrow_left_rounded),
          onPressed: () {
            Get.back(result: true);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // TOMBOL UNTUK MENCETAK DATA PEMASUKAN DALAM BENTUK PDF
          IconButton(
              icon: const Icon(Icons.print),
              onPressed: () async {
                await outcomeServices
                    .printDataOutcomeByDecadeId(selectedDataOutcome.id);
              })
        ],
      ),

      // BASE LIST PENGELUARAN PADA DEKADE TERTENTU
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
                      style: universalFonts,
                    ),
                    Text("Cash Out", style: universalFonts),
                  ],
                ),
              ),
            ),
          ),

          // BASE LIST DATA PENGELUARAN YANG TELAH DIINPUT
          Container(
              // color: Colors.yellow,
              margin: const EdgeInsets.only(bottom: 15),
              height: MediaQuery.of(context).size.height / 1.49,
              child: FutureBuilder(
                  future: newListDataOutcome,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: componentColors));
                    } else if (snapshot.hasError) {
                      return Text(
                        "Error: ${snapshot.error}",
                        style: universalFonts,
                      );
                    } else if (snapshot.data!.cashouts.isEmpty) {
                      return Center(
                          child: Text(
                        "Ooops, belum ada data yang tersimpan dalam database",
                        style: universalFonts,
                        textAlign: TextAlign.center,
                      ));
                    } else {
                      final getAllData = snapshot.data!;
                      getAllData.cashouts
                          .sort((a, b) => b.createdAt.compareTo(a.createdAt));
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: getAllData.cashouts.length,
                        itemBuilder: (context, index) {
                          final getData = getAllData.cashouts[index];
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
                                          Text(
                                            getData.jenisPengeluaran,
                                            style: boldComponentFonts,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),

                                          // DECADE PENGELUARAN DATA
                                          Text(
                                            dateTimeFormat(getAllData
                                                .cashouts[index].createdAt),
                                            style: universalFonts,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              "- ${formatCurrencyString("${getData.totalPengeluaran}")}",
                                              style: universalFonts),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              // BUTTON DETAIL DATA PEMASUKAN BERDASARKAN INDEX
                                              buttonControlDirection(
                                                  Icons.edit,
                                                  EditCashOutPage(
                                                    dataModel: getAllData,
                                                    index: index,
                                                  ),
                                                  () => refreshData(),
                                                  context),

                                              const SizedBox(
                                                width: 10,
                                              ),

                                              // BUTTON HAPUS SELURUH DATA PENGELUARAN BERDASARKAN DECADE
                                              buttonControlDelete(
                                                  Icons.delete_forever,
                                                  () async => await outcomeServices
                                                      .deleteDataOutcomeByType(
                                                          getAllData.id,
                                                          getData
                                                              .jenisPengeluaran),
                                                  getData.jenisPengeluaran,
                                                  refreshData,
                                                  context),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          );
                        },
                      );
                    }
                  })),

          // BUTTON UNTUK MENGINPUT DATA PENGELUARAN
          buttonDirection(
              "Cash Out",
              CashOutPage(
                decadeId: selectedDataOutcome.id,
              ),
              () => refreshData(),
              context),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: newListTotalDataOutcome,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else if (!snapshot.hasData) {
                return baseTotalOutcome(context, "--");
              } else {
                final getDataTotal = snapshot.data;
                return baseTotalOutcome(
                    context, "${getDataTotal!["totalPengeluaran"]}");
              }
            },
          ),
        ],
      ),
    );
  }

  // FUNCTION UNTUK BASE UI DARI TOTAL PENGELUARAN
  Align baseTotalOutcome(BuildContext context, String baseText) {
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
                  "Total Cash Out",
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
