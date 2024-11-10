import 'package:flutter/material.dart';
import 'package:pppl_apps/components/button_control.dart';
import 'package:pppl_apps/components/button_direction.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/screens/cash%20out/cash_out_page.dart';

class OutcomePage extends StatefulWidget {
  const OutcomePage({super.key});

  @override
  State<OutcomePage> createState() => _OutcomePageState();
}

class _OutcomePageState extends State<OutcomePage> {
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
                ListView.builder(
              shrinkWrap: true,
              itemCount: 50,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // BASE DARI SETIAP DATA PENGELUARAN YANG DIINPUT
                    Container(
                      color: universalColors,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // JENIS PENGELUARAN DATA
                                Text(
                                  "SPP",
                                  style: universalFonts,
                                ), // KETERANGAN PENGELUARAN
                                const SizedBox(
                                  height: 5,
                                ),

                                // TANGGAL PENGELUARAN DATA
                                Text("15 Oktober 2024",
                                    style:
                                        universalFonts) // TANGGAL PENGELUARAN
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // TOTAL HARGA PENGELUARAN
                                Text("- Rp. 30.000.000", style: universalFonts),
                                const SizedBox(height: 5),

                                // ICON EDIT DAN DELETE DATA PENGELUARAN
                                Row(
                                  children: [
                                    buttonControl(Icons.edit, context),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    buttonControl(Icons.info_outline, context),
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
            ),
          ),

          // BUTTON UNTUK MENGINPUT DATA PENGELUARAN
          buttonDirection("Cash Out", const CashOutPage(), context)
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
