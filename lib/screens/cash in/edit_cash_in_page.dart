import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pppl_apps/constant/app_color.dart';
import 'package:pppl_apps/constant/app_font.dart';
import 'package:pppl_apps/components/format_currency_controller.dart';
import 'package:pppl_apps/models/income_model.dart';
import 'package:pppl_apps/services/income_services.dart';

class EditCashInPage extends StatefulWidget {
  IncomeModel pemasukanModel;
  EditCashInPage({super.key, required this.pemasukanModel});

  @override
  State<EditCashInPage> createState() => _EditCashInPageState();
}

class _EditCashInPageState extends State<EditCashInPage> {
  TextEditingController danaBosController = TextEditingController();
  TextEditingController kelas1Controller = TextEditingController();
  TextEditingController kelas2Controller = TextEditingController();
  TextEditingController kelas3Controller = TextEditingController();
  TextEditingController kelas4Controller = TextEditingController();
  TextEditingController kelas5Controller = TextEditingController();
  TextEditingController kelas6Controller = TextEditingController();
  List<TextEditingController> inputUser = [];
  String hintTanggal = '--';
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
    initializeDateFormatting("id_ID", null);
    fetchDataAkhir();
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

  // FUNCTION UNTUK MENDAPATKAN DATA TERAKHIR BERDASARKAN DATA YANG DIPILIH PADA HALAMAN UTAMA
  Future<void> fetchDataAkhir() async {
    try {
      final allData = await IncomeServices().getAllDataIncome();
      final getData = widget.pemasukanModel;

      if (allData.isNotEmpty) {
        setState(() {
          danaBosController.text = getData.bos.toString();
          inputUser[0].text = getData.kelas1.toString();
          inputUser[1].text = getData.kelas2.toString();
          inputUser[2].text = getData.kelas3.toString();
          inputUser[3].text = getData.kelas4.toString();
          inputUser[4].text = getData.kelas5.toString();
          inputUser[5].text = getData.kelas6.toString();
          hintTanggal =
              DateFormat("yyyy", "ID_id").format(getData.tanggalPemasukan);
          dateNow = int.parse(hintTanggal);
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
          title: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Text(
                  "EDIT PEMASUKAN PERIODE",
                  style: whiteTitleFonts,
                ),
                Text(
                  "PERIODE: ${widget.pemasukanModel.tanggalPemasukan.year} / ${widget.pemasukanModel.tanggalPemasukan.year + 1}",
                  style: smallWhiteTitleFonts,
                )
              ],
            ),
          ),
          leading: IconButton(
            iconSize: 35,
            icon: const Icon(Icons.keyboard_arrow_left_rounded),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 42),
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
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 30),
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 27),
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

                              // ICON KALENDER UNTUK MEMILIH PERIODE
                              IconButton(
                                  icon: const Icon(Icons.calendar_month_sharp),
                                  onPressed: () {
                                    selectYear(context);
                                  })
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
                            DateTime konversiTanggalPemasukan = hintTanggal
                                    .isNotEmpty
                                ? DateFormat("yyyy", "id_ID").parse(hintTanggal)
                                : DateTime.now();

                            print(konversiDanaBos);
                            print(getKonversiKelas);
                            print(konversiTanggalPemasukan);

                            // MEMANGGIL METHOD updateDataPemasukan() UNTUK MEMPERBARUI DATA KE SERVER
                            await IncomeServices().updateDataIncome(
                              widget.pemasukanModel.id,
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
                                  "DATA BERHASIL DIPERBARUI",
                                  style: boldComponentFonts,
                                ),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          } catch (e, stackTrace) {
                            // MENAMPILKAN PESAN KESALAHAN
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  "HARAP MENGISIKAN PERIODE PEMASUKAN",
                                  style: boldComponentFonts,
                                ),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                            print("Error: $e");
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
