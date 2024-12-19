import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/services/outcome_service.dart';

class InputDecadePengeluaranPage extends StatefulWidget {
  const InputDecadePengeluaranPage({super.key});

  @override
  State<InputDecadePengeluaranPage> createState() =>
      _InputDecadePengeluaranPageState();
}

class _InputDecadePengeluaranPageState
    extends State<InputDecadePengeluaranPage> {
  TextEditingController tanggalController = TextEditingController();
  String hintTanggal = "--";
  late int dateNow;

  @override
  void initState() {
    super.initState();
    dateNow = DateTime.now().year;
  }

  // FUNCTION UNTUK MEMILIH TAHUN PERIODE
  void selectYear(context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Periode"),
          content: SizedBox(
            height: 300,
            width: 300,
            child: YearPicker(
                firstDate: DateTime(DateTime.now().year - 10),
                lastDate: DateTime(DateTime.now().year + 10),
                selectedDate: DateTime(dateNow),
                currentDate: DateTime(dateNow),
                onChanged: (DateTime dateTime) {
                  setState(() {
                    dateNow = dateTime.year;
                    hintTanggal = DateFormat("yyyy", "ID_id").format(dateTime);
                  });
                  Get.back();
                }),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthDivider = MediaQuery.of(context).size.width / 25;
    Intl.defaultLocale = 'id';
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: componentColors,
          title: Text("DEKADE PENGELUARAN", style: whiteTitleFonts),
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
          child: Column(children: [
            // BASE INPUT DECADE PENGELUARAN
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
                              "Input Decade Pengeluaran",
                              style: whiteBoldComponentFonts,
                              textAlign: TextAlign.center,
                            ),
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
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: widthDivider),
                                child: Center(
                                    child: Text(
                                  "PERIODE",
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
                                    icon:
                                        const Icon(Icons.calendar_month_sharp),
                                    onPressed: () {
                                      selectYear(context);
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
                          }
                          try {
                            // MELAKUKAN KONVERSI TANGGAL DARI STRING MENJADI DATETIME
                            DateTime konversiTanggalPemasukan =
                                DateFormat("yyyy", "id_ID").parse(hintTanggal);

                            await OutcomeServices()
                                .addNewDecadeOutcome(konversiTanggalPemasukan);

                            Get.back(result: true);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: universalColors,
                                content: Text(
                                  "ANDA BERHASIL MENGINPUT DEKADE PENGELUARAN",
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
                ))
          ]),
        ));
  }
}
