import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pppl_apps/constant/app_color.dart';
import 'package:pppl_apps/constant/app_font.dart';
import 'package:pppl_apps/components/format_currency_controller.dart';
import 'package:pppl_apps/services/income_services.dart';

class CashInPage extends StatefulWidget {
  const CashInPage({super.key});

  @override
  State<CashInPage> createState() => _CashInPageState();
}

class _CashInPageState extends State<CashInPage> {
  TextEditingController danaBosController = TextEditingController();
  TextEditingController kelas1Controller = TextEditingController();
  TextEditingController kelas2Controller = TextEditingController();
  TextEditingController kelas3Controller = TextEditingController();
  TextEditingController kelas4Controller = TextEditingController();
  TextEditingController kelas5Controller = TextEditingController();
  TextEditingController kelas6Controller = TextEditingController();
  List<TextEditingController> inputUser = [];
  String hintTanggal = "--";
  late int dateNow;

  @override
  void initState() {
    super.initState();
    inputUser = [
      kelas1Controller,
      kelas2Controller,
      kelas3Controller,
      kelas4Controller,
      kelas5Controller,
      kelas6Controller
    ];
    danaBosController
        .addListener(() => formatCurrencyController(danaBosController));

    for (var controller in inputUser) {
      controller.addListener(() => formatCurrencyController(controller));
    }
    dateNow = DateTime.now().year;
    initializeDateFormatting("id_ID", null);
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
    // MEMBERIKAN UKURAN DEFAULT YANG PASTI
    double widthDivider = MediaQuery.of(context).size.width / 20;
    Intl.defaultLocale = 'id';
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: componentColors,
          title: Text(
            "PEMASUKAN",
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

          // BASE CONTAINER INPUT PEMASUKAN
          child: Container(
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

              // CONTAINER YANG BERISIKAN ITEM PEMASUKAN
              child: ListView(
                children: [
                  Column(
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
                            "Uang Masuk",
                            style: whiteBoldComponentFonts,
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // BASE CONTAINER INPUT DANA BOS
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: componentColors, width: 2)),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: widthDivider + 18.5),
                                child: Center(
                                    child: Text(
                                  "BOS",
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

                              // CONTROLLER INPUT DATA DANA BOS
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
                                            controller: danaBosController,
                                            style: boldComponentFonts,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                prefixText: "Rp. ",
                                                prefixStyle: boldComponentFonts,
                                                border:
                                                    const OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none)),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: componentColors, width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                                child: Text(
                              "Komite",
                              style: boldComponentFonts,
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ),
                      ),

                      // BASE CONTAINER INPUT PEMASUKAN PER KELAS
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: inputUser.length,
                          itemBuilder: (context, index) {
                            TextEditingController getInputUser =
                                inputUser[index];
                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: componentColors, width: 2)),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: widthDivider + 3.5),
                                          child: Center(
                                              child: Text(
                                            "Kelas ${index + 1}",
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

                                        // CONTROLLER INPUT DATA PEMASUKAN PER KELAS
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                            child: Container(
                                              width: double.infinity,
                                              color: Colors.white,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller: getInputUser,
                                                      style: boldComponentFonts,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration: InputDecoration(
                                                          isDense: true,
                                                          prefixText: "Rp. ",
                                                          prefixStyle:
                                                              boldComponentFonts,
                                                          border:
                                                              const OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none)),
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
                                )
                              ],
                            );
                          }),

                      // CONTAINER INPUT TANGGAL
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: componentColors, width: 2),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: widthDivider),
                                child: Center(
                                  child: Text(
                                    "Tanggal",
                                    style: boldComponentFonts,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
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

                              // ICON KALENDER
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
                        height: 30,
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
                                  "HARAP MENGISI PERIODE PEMASUKAN",
                                  style: boldComponentFonts,
                                ),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                          try {
                            // MELAKUKAN KONVERSI TERHADAP DATA DANA BOS YANG AWALNYA STRING MENJADI INTEGER
                            int konversiDanaBos = danaBosController
                                    .text.isNotEmpty
                                ? int.parse(
                                    danaBosController.text.replaceAll('.', ''))
                                : 0;

                            /*
                            MELAKUKAN KONVERSI TERHADAP SELURUH DATA KELAS YANG AWALNYA STRING MENJADI INTEGER
                            MENYIMPANNYA KE DALAM BENTUK LIST
                            */
                            List<int> getKonversiKelas =
                                inputUser.map((controller) {
                              if (controller.text.isNotEmpty) {
                                return int.parse(
                                    controller.text.replaceAll('.', ''));
                              } else {
                                return 0;
                              }
                            }).toList();

                            // MELAKUKAN KONVERSI TANGGAL DARI STRING MENJADI DATETIME
                            DateTime konversiTanggalPemasukan =
                                DateFormat("yyyy", "id_ID").parse(hintTanggal);

                            print(konversiDanaBos);
                            print(getKonversiKelas);
                            print(konversiTanggalPemasukan);

                            // MEMANGGIL METHOD addNewDataPemasukan() UNTUK MENGINPUT DATA KE SERVER
                            await IncomeServices().addNewDataIncome(
                              konversiDanaBos,
                              getKonversiKelas[0],
                              getKonversiKelas[1],
                              getKonversiKelas[2],
                              getKonversiKelas[3],
                              getKonversiKelas[4],
                              getKonversiKelas[5],
                              konversiTanggalPemasukan,
                            );

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
                            print("Error Pada Saat Memasukkan Data: $e");
                            print("Stack Trace: $stackTrace");
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
