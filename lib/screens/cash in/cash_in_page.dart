import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';

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
  TextEditingController tanggalController = TextEditingController();
  String hintTanggal = "--";
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
    for (var controller in inputUser) {
      controller.addListener(() => formatCurrency(controller));
    }
    danaBosController.addListener(() => formatCurrency(danaBosController));
    initializeDateFormatting("id_ID", null);
  }

  void formatCurrency(TextEditingController controller) {
    String value = controller.text.replaceAll('.', '').replaceAll(',', '');
    if (value.isEmpty) return;

    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
    final intValue = int.tryParse(value);
    if (intValue != null) {
      final newValue = formatter.format(intValue).replaceAll(',', '.');
      controller.value = controller.value.copyWith(
        text: newValue,
        selection: TextSelection.collapsed(offset: newValue.length),
      );
    }
  }

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
            "PEMASUKAN",
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
                                    vertical: 10, horizontal: 46),
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

                                        // CONTROLLER INPUT PEMASUKAN
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
                                    vertical: 10, horizontal: 26),
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
                        onTap: () {
                          for (var controller in inputUser) {
                            print(danaBosController.text);
                            print(controller.text);
                            print(tanggalController.text);
                            // danaBosController.text = "";
                            // controller.text = "";
                            // tanggalController.text = "--";
                          }
                          Get.back();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: universalColors,
                              content: Text("DATA BERHASIL DISIMPAN",
                                  style: universalFonts),
                              duration: const Duration(seconds: 3),
                            ),
                          );
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
