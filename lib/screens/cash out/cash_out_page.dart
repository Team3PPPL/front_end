import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/components/format_currency_controller.dart';
import 'package:pppl_apps/constant/list_pengeluaran.dart' as getPengeluaran;

class CashOutPage extends StatefulWidget {
  const CashOutPage({super.key});

  @override
  State<CashOutPage> createState() => _CashOutPageState();
}

class _CashOutPageState extends State<CashOutPage> {
  TextEditingController pengeluaranController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  String? selectedItem;
  String hintTanggal = "--";

  @override
  void initState() {
    super.initState();
    pengeluaranController
        .addListener(() => formatCurrencyController(pengeluaranController));
    initializeDateFormatting("id_ID", null);
  }

  // FUNCTION UNTUK MEMILIH TANGGAL MELALUI KALENDER
  Future<void> selectDate() async {
    DateTime? setDate = await showDatePicker(
      context: context,
      locale: const Locale("id", "ID"),
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2050),
    );
    if (setDate != null) {
      setState(() {
        hintTanggal = DateFormat("d MMMM yyyy", "id_ID").format(setDate);
      });
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
          "PENGELUARAN",
          style: whiteTitleFonts,
        ),
        centerTitle: true,
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
                        child:
                            // BASE DROPDOWN BUTTON YANG DAPAT MENAMPILKAN SELURUH JENIS PENGELUARAN
                            DropdownButton<String>(
                                value: selectedItem,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                dropdownColor: universalColors,
                                isExpanded: true,
                                underline: Container(),
                                alignment: Alignment.center,
                                menuWidth:
                                    MediaQuery.of(context).size.width / 1.19,
                                hint: Text(
                                  "JENIS PENGELUARAN",
                                  style: boldComponentFonts,
                                  textAlign: TextAlign.center,
                                ),
                                items: getPengeluaran.allPengeluaran.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: universalFonts,
                                    ),
                                  );
                                }).toList(),
                                selectedItemBuilder: (context) {
                                  return getPengeluaran.allPengeluaran.map((e) {
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 18.5),
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

                            // CONTROLLER INPUT TANGGAL PENGELUARAN
                            Expanded(
                              child: TextFormField(
                                controller: tanggalController,
                                style: boldComponentFonts,
                                readOnly: true,
                                decoration: InputDecoration(
                                    isDense: true,
                                    hintText: hintTanggal,
                                    hintMaxLines: 2,
                                    suffixIcon:
                                        const Icon(Icons.calendar_month_sharp),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                                onTap: () {
                                  selectDate();
                                },
                              ),
                            ),
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
                        // try {
                        //   // MELAKUKAN KONVERSI TERHADAP DATA BOS YANG AWALNYA STRING MENJADI INTEGER
                        //   int konversiPengeluaranController = int.parse(
                        //       pengeluaranController.text.replaceAll('.', ''));

                        //   // MELAKUKAN KONVERSI TANGGAL DARI STRING MENJADI DATETIME
                        //   DateTime konversiTanggalPemasukan =
                        //       DateFormat("d MMMM yyyy", "id_ID")
                        //           .parse(tanggalController.text);

                        //   // MEMANGGIL METHOD addNewDataPengeluaran() UNTUK MENGINPUT DATA KE SERVER
                        //   await PengeluaranServices().addNewDataPengeluaran(
                        //       konversiPengeluaranController,
                        //       konversiTanggalPemasukan);

                        //   Get.back(result: true);
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       backgroundColor: universalColors,
                        //       content: Text("DATA BERHASIL DITAMBAHKAN",
                        //           style: boldComponentFonts),
                        //       duration: const Duration(seconds: 3),
                        //     ),
                        //   );
                        // } catch (e) {
                        //   print("Error: $e");
                        // } finally {
                        //   Get.back();
                        // }
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
