import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/components/format_currency_controller.dart';
import 'package:pppl_apps/models/pemasukan_model.dart';
import 'package:pppl_apps/services/pemasukan_services.dart';

class EditCashInPage extends StatefulWidget {
  PemasukanModel pemasukanModel;
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
  TextEditingController tanggalController = TextEditingController();
  String hintTanggal = '--';
  List<TextEditingController> inputUser = [];

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

  // FUNCTION UNTUK MENDAPATKAN DATA TERAKHIR BERDASARKAN DATA YANG DIPILIH PADA HALAMAN UTAMA
  Future<void> fetchDataAkhir() async {
    try {
      final allData = await PemasukanServices().getAllDataPemasukan();
      final getData = widget.pemasukanModel;

      if (allData.isNotEmpty) {
        setState(() {
          int id = getData.id;
          danaBosController.text = getData.bos.toString();
          inputUser[0].text = getData.kelas1.toString();
          inputUser[1].text = getData.kelas2.toString();
          inputUser[2].text = getData.kelas3.toString();
          inputUser[3].text = getData.kelas4.toString();
          inputUser[4].text = getData.kelas5.toString();
          inputUser[5].text = getData.kelas6.toString();
          tanggalController.text = DateFormat("d MMMM yyyy", "id_ID")
              .format(getData.tanggalPemasukan);
        });
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
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
      tanggalController.text =
          DateFormat("d MMMM yyyy", "id_ID").format(setDate);
      hintTanggal = tanggalController.text;
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
            "EDIT PEMASUKAN PERIODE",
            style: whiteTitleFonts,
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child:
              // BASE CONTAINER INPUT PEMASUKAN
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
              child:

                  // CONTAINER YANG BERISIKAN ITEM PEMASUKAN
                  ListView(
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

                              // CONTROLLER INPUT TANGGAL
                              Expanded(
                                child: TextFormField(
                                  controller: tanggalController,
                                  style: boldComponentFonts,
                                  readOnly: true,
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintText: hintTanggal,
                                      hintMaxLines: 2,
                                      suffixIcon: const Icon(
                                          Icons.calendar_month_sharp),
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
                          try {
                            // MELAKUKAN KONVERSI TERHADAP DATA DANA BOS YANG AWALNYA STRING MENJADI INTEGER
                            int konversiDanaBos = int.parse(
                                danaBosController.text.replaceAll('.', ''));

                            /*
                            MELAKUKAN KONVERSI TERHADAP SELURUH DATA KELAS YANG AWALNYA STRING MENJADI INTEGER
                            MENYIMPANNYA KE DALAM BENTUK LIST
                            */
                            List<int> getKonversiKelas =
                                inputUser.map((controller) {
                              return int.parse(
                                  controller.text.replaceAll('.', ''));
                            }).toList();

                            // MELAKUKAN KONVERSI TANGGAL DARI STRING MENJADI DATETIME
                            DateTime konversiTanggalPemasukan =
                                DateFormat("d MMMM yyyy", "id_ID")
                                    .parse(tanggalController.text);

                            // MEMANGGIL METHOD updateDataPemasukan() UNTUK MEMPERBARUI DATA KE SERVER
                            await PemasukanServices().updateDataPemasukan(
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
                                content: Text("DATA BERHASIL DIUPDATE",
                                    style: boldComponentFonts),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          } catch (e) {
                            print("Error: $e");
                          } finally {
                            Get.back();
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