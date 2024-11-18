import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pppl_apps/components/button_control_delete.dart';
import 'package:pppl_apps/components/button_controller_direction.dart';
import 'package:pppl_apps/components/button_text_direction.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/models/pengeluaran_model.dart';
import 'package:pppl_apps/screens/cash%20out/cash_out_page.dart';
import 'package:pppl_apps/screens/cash%20out/detail_outcome_page.dart';
import 'package:pppl_apps/screens/cash%20out/edit_cash_out_page.dart';
import 'package:pppl_apps/services/pengeluaran_service.dart';

class OutcomePage extends StatefulWidget {
  const OutcomePage({super.key});

  @override
  State<OutcomePage> createState() => _OutcomePageState();
}

class _OutcomePageState extends State<OutcomePage> {
  late Future<List<PengeluaranModel>> newDataPengeluaran;
  final PengeluaranServices pengeluaranServices = PengeluaranServices();

  @override
  void initState() {
    super.initState();
    newDataPengeluaran = pengeluaranServices.getAllDataPengeluaran();
  }

  // FUNCTION UNTUK MEMPERBARUI DATA SETIAP ADA PERUBAHAN YANG TERJADI
  void refreshData() async {
    await PengeluaranServices().getAllDataPengeluaran();
    setState(() {
      newDataPengeluaran = pengeluaranServices.getAllDataPengeluaran();
    });
  }

  // FUNCTION UNTUK MELAKUKAN FORMAT TERHADAP MATA UANG
  String formatCurrency(String value) {
    final number =
        int.tryParse(value.replaceAll('.', '').replaceAll('.', '')) ?? 0;
    final format =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return format.format(number);
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
      body:
          // BASE DETAIL PENGELUARAN
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
                                              // JENIS PENGELUARAN DATA
                                              Text(
                                                "${getData.jenisPengeluaran}",
                                                style: boldComponentFonts,
                                              ), // KETERANGAN PENGELUARAN
                                              const SizedBox(
                                                height: 5,
                                              ),

                                              // TANGGAL PENGELUARAN DATA
                                              Text(
                                                  formatDate(getData
                                                      .tanggalPengeluaran),
                                                  style:
                                                      universalFonts) // TANGGAL PENGELUARAN
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              // TOTAL HARGA PENGELUARAN
                                              Text(
                                                  "- ${formatCurrency("${getData.jenisPengeluaran}")}",
                                                  style: universalFonts),
                                              const SizedBox(height: 5),

                                              // ICON EDIT DAN DELETE DATA PENGELUARAN
                                              Row(
                                                children: [
                                                  // BUTTON EDIT DATA PEMASUKAN BERDASARKAN INDEX
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

                                                  // BUTTON HAPUS DATA PEMASUKAN BERDASARKAN ID
                                                  buttonControlDelete(
                                                    Icons.delete_forever,
                                                    () async =>
                                                        await PengeluaranServices()
                                                            .deleteDataPengeluaran(
                                                                getData.id),
                                                    () => refreshData(),
                                                    context,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),

                                                  // BUTTON DETAIL DATA PEMASUKAN BERDASARKAN INDEX
                                                  buttonControlDirection(
                                                      Icons.info_outline,
                                                      DetailOutcomePage(
                                                        pengeluaranModel:
                                                            getData,
                                                      ),
                                                      () => refreshData(),
                                                      context),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
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
      bottomSheet: Padding(
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

                // CONTAINER UNTUK MENAMPILKAN TOTAL DATA PENGELUARAN
                Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "Rp. 32.000.000",
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
