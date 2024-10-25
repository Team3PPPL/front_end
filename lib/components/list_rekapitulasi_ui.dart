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
    return Column(children: [
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
        height: MediaQuery.of(context).size.height / 1.5,
        child: PageView.builder(
          controller: pageController,
          itemCount: 3,
          itemBuilder: (_, index) {
            dynamic getListRekap = listRekap[
                index]; // MENDAPATKAN DATA JENIS REKAP BERDASARKAN INDEX
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
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(20)),
                            color: universalColors),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 10.3,
                          width: MediaQuery.of(context).size.width / 1.123,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(17)),
                              color: Colors.white),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(10),
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
                        return listRekapMethod(index, rekapLembaga, isLastItem);
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
    ]);
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        getRekap.keteranganRekap,
                        style: universalFonts,
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Text("${getRekap.detailRekap}",
                            style: universalFonts)),
                  ],
                ),
              ),
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
