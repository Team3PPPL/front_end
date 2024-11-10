import 'package:flutter/material.dart';
import 'package:pppl_apps/components/button_control.dart';
import 'package:pppl_apps/components/button_direction.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/screens/cash%20in/cash_in_page.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: componentColors,
        title: Text(
          "PEMASUKAN",
          style: whiteTitleFonts,
        ),
        centerTitle: true,
      ),
      body:
          // BASE DETAIL PEMASUKAN
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
                    Text("Cash In", style: universalFonts),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            height: MediaQuery.of(context).size.height / 1.75,
            child:
                // BASE LIST DATA PEMASUKAN YANG TELAH DIINPUT
                ListView.builder(
              shrinkWrap: true,
              itemCount: 50,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // BASE DARI SETIAP DATA PEMASUKAN YANG DIINPUT
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
                                // JENIS PEMASUKAN DATA
                                Text(
                                  "SPP",
                                  style: universalFonts,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),

                                // TANGGAL PEMASUKAN DATA
                                Text("15 Oktober 2024", style: universalFonts)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // TOTAL HARGA PEMASUKAN
                                Text("+ Rp. 20.000.000", style: universalFonts),
                                const SizedBox(height: 5),

                                // ICON EDIT DAN DELETE DATA PEMASUKAN
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

          // BUTTON UNTUK MENGINPUT DATA PEMASUKAN
          buttonDirection("Cash In", const CashInPage(), context)
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

                // CONTAINER UNTUK MENAMPILKAN TOTAL DATA PEMASUKAN
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
