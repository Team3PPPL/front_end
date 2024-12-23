import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pppl_apps/constant/app_color.dart';
import 'package:pppl_apps/constant/app_font.dart';
import 'package:pppl_apps/components/format_currency_controller.dart';
import 'package:pppl_apps/constant/list_pengeluaran.dart' as get_pengeluaran;
import 'package:pppl_apps/services/outcome_service.dart';

class CashOutPage extends StatefulWidget {
  int decadeId;
  CashOutPage({super.key, required this.decadeId});

  @override
  State<CashOutPage> createState() => _CashOutPageState();
}

class _CashOutPageState extends State<CashOutPage> {
  TextEditingController pengeluaranController = TextEditingController();
  String? selectedItem;
  String hintTanggal = "--";
  late DateTime dateNow;

  @override
  void initState() {
    super.initState();
    pengeluaranController
        .addListener(() => formatCurrencyController(pengeluaranController));
    initializeDateFormatting("id_ID", null);
  }

  // FUNCTION UNTUK MEMILIH TANGGAL MELALUI KALENDER
  Future<void> selectDate() async {
    if (hintTanggal.isNotEmpty) {
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
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (setDate != null) {
      setState(() {
        hintTanggal = DateFormat("d MMMM yyyy", "id_ID").format(setDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // MEMBERIKAN UKURAN DEFAULT YANG PASTI
    double widthDivider = MediaQuery.of(context).size.width / 25;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: componentColors,
        title: Text(
          "PENGELUARAN",
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

        // BASE CONTAINER INPUT PENGELUARAN
        child: Column(
          children: [
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

                        // BASE DROPDOWN BUTTON YANG DAPAT MENAMPILKAN SELURUH JENIS PENGELUARAN
                        child: DropdownButton(
                            value: selectedItem,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: widthDivider),
                            dropdownColor: universalColors,
                            isExpanded: true,
                            underline: Container(),
                            alignment: Alignment.center,
                            menuWidth: MediaQuery.of(context).size.width / 1.19,
                            hint: Text(
                              "JENIS PENGELUARAN",
                              style: boldComponentFonts,
                              textAlign: TextAlign.center,
                            ),
                            items: get_pengeluaran.allPengeluaran.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: universalFonts,
                                ),
                              );
                            }).toList(),
                            selectedItemBuilder: (context) {
                              return get_pengeluaran.allPengeluaran.map((e) {
                                return Center(
                                    child: Text(
                                  e,
                                  style: boldComponentFonts,
                                ));
                              }).toList();
                            },
                            onChanged: (value) {
                              setState(() {
                                selectedItem = value!;
                              });
                            })),
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
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: widthDivider),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
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

                            // ICON KALENDER UNTUK MEMILIH TANGGAL PENGELUARAN
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
                        if (selectedItem == null || selectedItem!.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "HARAP MENGISI JENIS PENGELUARAN",
                                style: boldComponentFonts,
                              ),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                          return;
                        }
                        if (hintTanggal == "--") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "HARAP MENGISI PERIODE PENGELUARAN",
                                style: boldComponentFonts,
                              ),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                          return;
                        }
                        try {
                          // MELAKUKAN KONVERSI TERHADAP DATA DANA BOS YANG AWALNYA STRING MENJADI INTEGER
                          int konversiPengeluaran =
                              pengeluaranController.text.isNotEmpty
                                  ? int.parse(pengeluaranController.text
                                      .replaceAll('.', ''))
                                  : 0;

                          await OutcomeServices().addNewDataOutcome(
                              widget.decadeId,
                              selectedItem!,
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
