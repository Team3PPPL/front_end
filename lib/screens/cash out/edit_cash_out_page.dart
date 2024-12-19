import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pppl_apps/components/format_date_string.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/components/format_currency_controller.dart';
import 'package:pppl_apps/models/outcome_model.dart';
import 'package:pppl_apps/constant/list_pengeluaran.dart' as getPengeluaran;
import 'package:pppl_apps/services/outcome_service.dart';

class EditCashOutPage extends StatefulWidget {
  DataModel dataModel;
  int index;
  EditCashOutPage({super.key, required this.dataModel, required this.index});

  @override
  State<EditCashOutPage> createState() => _EditCashOutPageState();
}

class _EditCashOutPageState extends State<EditCashOutPage> {
  TextEditingController pengeluaranController = TextEditingController();
  String? selectedItem;
  String hintTanggal = "--";
  String hintText = "Jenis Pengeluaran";
  late DateTime dateNow;
  late DateTime currentDate;

  @override
  void initState() {
    super.initState();
    pengeluaranController
        .addListener(() => formatCurrencyController(pengeluaranController));
    initializeDateFormatting("id_ID", null);
    fetchDataAkhir();
  }

  // FUNCTION UNTUK MEMILIH TANGGAL MELALUI KALENDER
  Future<void> selectDate() async {
    if (hintTanggal != "--") {
      try {
        dateNow = DateFormat("d MMMM yyyy", "id_ID").parse(hintTanggal);
      } catch (e) {
        dateNow = DateTime.now();
      }
    } else {
      dateNow = DateTime.now();
    }

    DateTime? setDate = await showDatePicker(
      context: context,
      locale: const Locale("id", "ID"),
      initialDate: dateNow,
      currentDate: currentDate,
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (setDate != null) {
      setState(() {
        hintTanggal = DateFormat("d MMMM yyyy", "id_ID").format(setDate);
      });
    }
  }

  // FUNCTION UNTUK MENDAPATKAN DATA TERAKHIR BERDASARKAN DATA YANG DIPILIH PADA HALAMAN UTAMA
  Future<void> fetchDataAkhir() async {
    try {
      final allData = await OutcomeServices().getDataInDecade(
          widget.dataModel.id,
          widget.dataModel.cashouts[widget.index].jenisPengeluaran);
      if (allData.jenisPengeluaran.isNotEmpty) {
        setState(() {
          final getData = widget.dataModel;
          // selectedItem = allData.jenisPengeluaran;
          pengeluaranController.text =
              getData.cashouts[widget.index].totalPengeluaran.toString();
          hintTanggal =
              dateTimeFormat(getData.cashouts[widget.index].createdAt);
          currentDate = DateFormat("d MMMM yyyy", "id_ID").parse(hintTanggal);
        });
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'id';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: componentColors,
        title: Text(
          "EDIT PENGELUARAN",
          style: whiteTitleFonts,
        ),
        centerTitle: true,
        leading: IconButton(
          iconSize: 35,
          icon: const Icon(Icons.keyboard_arrow_left_rounded),
          onPressed: () {
            Get.back();
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            // BASE CONTAINER INPUT PENGELUARAN
            Container(
              decoration: BoxDecoration(
                color: universalColors,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 2, color: componentColors),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: componentColors,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Text(
                            "Uang Keluar",
                            style: whiteBoldComponentFonts,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // BASE CONTAINER JENIS PENGELUARAN
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: componentColors, width: 2)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          child: Text(
                            widget.dataModel.cashouts[widget.index]
                                .jenisPengeluaran,
                            style: boldComponentFonts,
                            textAlign: TextAlign.center,
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),

                    // CONTAINER INPUT CASH OUT
                    IntrinsicHeight(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: componentColors, width: 2)),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 21),
                              child: Center(
                                  child: Text(
                                "Cash Out",
                                style: boldComponentFonts,
                                textAlign: TextAlign.center,
                              )),
                            ),

                            // GARIS PEMBATAS SECARA VERTIKAL (HARUS MENGGUNAKAN WIDGET INTRINSICHEIGHT)
                            const VerticalDivider(
                              color: componentColors,
                              thickness: 2,
                              indent: 5,
                              endIndent: 5,
                              width: 1.5,
                            ),

                            // CONTROLLER INPUT DATA DARI JENIS PENGELUARAN
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: pengeluaranController,
                                          style: boldComponentFonts,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              prefixText: "Rp. ",
                                              prefixStyle: boldComponentFonts,
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide.none)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // CONTAINER INPUT TANGGAL
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: componentColors, width: 2),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 26),
                              child: Center(
                                  child: Text(
                                "Tanggal",
                                style: boldComponentFonts,
                                textAlign: TextAlign.center,
                              )),
                            ),

                            // GARIS PEMBATAS SECARA VERTIKAL (HARUS MENGGUNAKAN WIDGET INTRINSICHEIGHT)
                            const VerticalDivider(
                              color: componentColors,
                              thickness: 2,
                              indent: 5,
                              endIndent: 5,
                              width: 1.5,
                            ),

                            // CONTAINER INPUT TANGGAL
                            Expanded(
                              child: Text(
                                hintTanggal,
                                style: boldComponentFonts,
                                textAlign: TextAlign.center,
                              ),
                            ),

                            // ICON CALENDAR
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  icon: const Icon(Icons.calendar_month_sharp),
                                  onPressed: () {
                                    selectDate();
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    // BUTTON SIMPAN DATA
                    GestureDetector(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.width / 8,
                          width: MediaQuery.of(context).size.width / 3.5,
                          decoration: BoxDecoration(
                              color: componentColors,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                            "SAVE",
                            style: whiteBoldComponentFonts,
                          )),
                        ),
                      ),
                      onTap: () async {
                        print("DECADE ID: ${widget.dataModel.id}");
                        print(
                            "Jenis pengeluaran: ${widget.dataModel.cashouts[widget.index].jenisPengeluaran}");
                        print(pengeluaranController.text);
                        try {
                          // MELAKUKAN KONVERSI TERHADAP DATA DANA BOS YANG AWALNYA STRING MENJADI INTEGER
                          int konversiPengeluaran = int.parse(
                              pengeluaranController.text.replaceAll('.', ''));

                          await OutcomeServices().updateDataPengeluaranInDecade(
                              widget.dataModel.id,
                              widget.dataModel.cashouts[widget.index]
                                  .jenisPengeluaran,
                              konversiPengeluaran);

                          Get.back(result: true);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: universalColors,
                              content: Text(
                                "DATA BERHASIL DITAMBAHKAN",
                                style: boldComponentFonts,
                              ),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        } catch (e, stackTrace) {
                          print("Error: $e");
                          print("Stack Trace: $stackTrace");
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
