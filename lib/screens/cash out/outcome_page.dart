import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pppl_apps/components/button_control_delete_decade.dart';
import 'package:pppl_apps/components/button_control_direction.dart';
import 'package:pppl_apps/components/button_text_direction.dart';
import 'package:pppl_apps/components/format_currency_string.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/models/outcome_model.dart';
import 'package:pppl_apps/screens/cash%20out/input_decade_pengeluaran.dart';
import 'package:pppl_apps/screens/cash%20out/list_pengeluaran_in_decade_page.dart';
import 'package:pppl_apps/services/outcome_service.dart';
import 'package:pppl_apps/services/total_outcome_service.dart';

class OutcomePage extends StatefulWidget {
  const OutcomePage({super.key});

  @override
  State<OutcomePage> createState() => _OutcomePageState();
}

class _OutcomePageState extends State<OutcomePage> {
  late Future<OutcomeModel> newDataOutcome;
  late Future<Map<String, dynamic>> newTotalDataOutcome;
  final OutcomeServices outcomeServices = OutcomeServices();
  final TotalOutcomeServices totalOutcomeService = TotalOutcomeServices();

  @override
  void initState() {
    super.initState();
    newDataOutcome = outcomeServices.getAllDataOutcome();
    newTotalDataOutcome = totalOutcomeService.getAllDataTotalOutcome();
  }

  // FUNCTION UNTUK MEMPERBARUI DATA SETIAP ADA PERUBAHAN YANG TERJADI
  void refreshData() async {
    await OutcomeServices().getAllDataOutcome();
    await TotalOutcomeServices().getAllDataTotalOutcome();
    setState(() {
      newDataOutcome = outcomeServices.getAllDataOutcome();
      newTotalDataOutcome = totalOutcomeService.getAllDataTotalOutcome();
    });
  }

  // FUNCTION UNTUK MELAKUKAN FORMAT TERHADAP TANGGAL
  String formatDate(DateTime date) {
    final dateFormat = DateFormat("d MMMM yyyy", "id_ID").format(date);
    return dateFormat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: componentColors,
        title: Text(
          "PENGELUARAN",
          style: whiteTitleFonts,
        ),
        centerTitle: true,
      ),

      // BASE DETAIL PENGELUARAN
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
              margin: const EdgeInsets.only(bottom: 15),
              height: MediaQuery.of(context).size.height / 1.68,
              child: FutureBuilder(
                  future: newDataOutcome,
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
                    } else if (!snapshot.hasData) {
                      return Center(
                          child: Text(
                        "Ooops, belum ada data yang tersimpan dalam database",
                        style: universalFonts,
                      ));
                    } else {
                      final getAllData = snapshot.data!;
                      getAllData.data!.sort((a, b) => b.id.compareTo(a.id));
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: getAllData.data!.length,
                        itemBuilder: (context, index) {
                          final getData = getAllData.data![index];
                          return FutureBuilder(
                            future: totalOutcomeService
                                .getAllDataTotalOutcomeByDecadeId(getData.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  !snapshot.hasData) {
                                return baseListDecadeOutcome(
                                    getData, getAllData, index, "0");
                              } else {
                                final getTotalIncome = snapshot.data!;
                                return baseListDecadeOutcome(
                                    getData,
                                    getAllData,
                                    index,
                                    "${getTotalIncome["totalPengeluaran"]}");
                              }
                            },
                          );
                        },
                      );
                    }
                  })),

          // BUTTON UNTUK MENGINPUT DATA PENGELUARAN
          buttonDirection("Input Decade", const InputDecadePengeluaranPage(),
              () => refreshData(), context),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: newTotalDataOutcome,
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

  // FUNCTION UNTUK BASE UI DARI LIST DEKADE PENGELUARAN
  Column baseListDecadeOutcome(DataModel getData, OutcomeModel getAllData,
      int index, String totalPengeluaran) {
    return Column(
      children: [
        // BASE DARI SETIAP DATA PENGELUARAN YANG DIINPUT
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
                    // DECADE PENGELUARAN DATA
                    Text(
                      "Periode: ${getData.decade.year} / ${getData.decade.year + 1} ",
                      style: boldComponentFonts,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "- ${formatCurrencyString(totalPengeluaran)}",
                      style: universalFonts,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("${getData.id}")
                  ],
                ),
                Row(
                  children: [
                    // BUTTON HAPUS SELURUH DATA PENGELUARAN BERDASARKAN DECADE
                    buttonControlDeleteDecade(
                        Icons.delete_forever,
                        () async => await outcomeServices
                            .deleteAllDataOutcomeByDecadeId(getData.id),
                        "${getData.decade.year} / ${getData.decade.year + 1}",
                        refreshData,
                        context),

                    const SizedBox(
                      width: 10,
                    ),

                    // BUTTON DETAIL DATA PEMASUKAN BERDASARKAN INDEX
                    buttonControlDirection(
                        Icons.info_outline,
                        ListsPengeluaranInDecadePage(
                          outcomeModel: getAllData,
                          indexData: index,
                        ),
                        () => refreshData(),
                        context),
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
