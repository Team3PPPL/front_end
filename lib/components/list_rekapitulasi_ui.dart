import 'package:flutter/material.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/constant/list_rekapitulasi.dart';
import 'package:pppl_apps/model/rekap_model.dart';

class ListRekapitulasiUI extends StatefulWidget {
  const ListRekapitulasiUI({super.key});

  @override
  State<ListRekapitulasiUI> createState() => _ListRekapitulasiUIState();
}

class _ListRekapitulasiUIState extends State<ListRekapitulasiUI> {
  late PageController pageController;
  int viewIndex = 0;
  List listRekap = [
    "Rekapitulasi Lembaga",
    "Rekapitulasi Siswa",
    "Rekapitulasi Pendidik Tenaga Kependidikan"
  ];

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child:
                  // ICON BULLET UNTUK SLIDE REKAP
                  Icon(
                Icons.circle,
                size: 10,
                color: viewIndex == index ? Colors.black : Colors.grey,
              ),
            );
          }),
        ),
        const SizedBox(
          height: 10,
        ),

        // BASE UI REKAPITULASI
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.23,
          child: PageView.builder(
            controller: pageController,
            itemCount: 3,
            itemBuilder: (_, index) {
              // MENDAPATKAN DATA JENIS REKAP BERDASARKAN INDEX
              dynamic getListRekap = listRekap[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    // HEADER ITEM REKAPITULASI
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 10,
                          decoration: const BoxDecoration(
                            color: componentColors,
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(20)),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 10.3,
                            width: MediaQuery.of(context).size.width / 1.123,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(17))),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                getListRekap,
                                style: titleFonts,
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),

                    // MENAMPILKAN SELURUH DATA REKAP BERDASARKAN JENIS REKAPAN
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: viewIndex == 0
                          ? rekapLembaga.length
                          : viewIndex == 1
                              ? rekapSiswa.length
                              : rekapPTK.length,
                      itemBuilder: (_, index) {
                        // MENDAPATKAN JENIS REKAPAN BERDASARKAN INDEX SAAT INI
                        var currentList = viewIndex == 0
                            ? rekapLembaga
                            : viewIndex == 1
                                ? rekapSiswa
                                : rekapPTK;

                        // MENDAPATKAN ITEM TERAKHIR DARI JENIS REKAPAN YANG DIPILIH
                        bool isLastItem = index == currentList.length - 1;
                        if (viewIndex == 0) {
                          return listRekapMethod(
                              index, rekapLembaga, isLastItem);
                        } else if (viewIndex == 1) {
                          return listRekapMethod(index, rekapSiswa, isLastItem);
                        } else {
                          return listRekapMethod(index, rekapPTK, isLastItem);
                        }
                      },
                    )
                  ],
                ),
              );
            },
            onPageChanged: (value) {
              setState(() {
                viewIndex = value;
              });
            },
          ),
        ),
      ]),
    );
  }

  // LIST DATA REKAP BERDASARKAN JENIS REKAPAN
  listRekapMethod(int index, dynamic method, bool isLastItem) {
    RekapModel getRekap = method[index];
    return ClipRRect(
      borderRadius: isLastItem == true
          ? const BorderRadius.only(
              bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))
          : const BorderRadius.all(Radius.zero),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: viewIndex == 0
                      ?
                      // TAMPILAN DETAIL REKAPAN JIKA JENIS REKAPAN SAAT INI BERINDEKS 0
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                getRekap.keteranganRekap,
                                style: universalFonts,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: Text("${getRekap.detailRekap}",
                                    style: universalFonts)),
                          ],
                        )
                      :

                      // TAMPILAN DETAIL REKAPAN JIKA JENIS REKAPAN SAAT INI BUKAN BERINDEKS 0
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.person),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                getRekap.keteranganRekap,
                                style: universalFonts,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 10,
                                child: Text("${getRekap.detailRekap}",
                                    style: universalFonts)),
                          ],
                        )),
              Divider(
                color: isLastItem == false ? Colors.grey : Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
