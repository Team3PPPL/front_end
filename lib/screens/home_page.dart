import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pppl_apps/components/all_data_students_ui.dart';
import 'package:pppl_apps/components/format_currency_string.dart';
import 'package:pppl_apps/components/format_date_string.dart';
import 'package:pppl_apps/components/split_data_students_ui.dart';
import 'package:pppl_apps/constant/app_color.dart';
import 'package:pppl_apps/constant/app_font.dart';
import 'package:pppl_apps/models/outcome_model.dart';
import 'package:pppl_apps/services/income_services.dart';
import 'package:pppl_apps/services/outcome_service.dart';
import 'package:pppl_apps/services/students_services.dart';
import 'package:pppl_apps/services/total_income_service.dart';
import 'package:pppl_apps/services/total_outcome_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting("id", null);
  }

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'id';
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        AppBar(
          backgroundColor: componentColors,
          // toolbarHeight: MediaQuery.of(context).size.height / 10,
          title: Text(
            DateFormat("d MMMM yyyy", "id").format(DateTime.now()),
            style: whiteTitleFonts,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(height: 15),

              FutureBuilder(
                  future: StudentsServices().getAllDataStudent(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return baseStudents(0, 0, 0);
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      final getDataStudent = snapshot.data;
                      return baseStudents(
                          getDataStudent!.totalKeseluruhan,
                          getDataStudent.totalSiswaCowok,
                          getDataStudent.totalSiswaCewek);
                    }
                  }),

              const SizedBox(
                height: 50,
              ),

              // CONTAINER TANGGAL PERIODE KEUANGAN
              FutureBuilder(
                future: OutcomeServices().getAllDataOutcome(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return baseFinance("--", DataModel.empty());
                  } else if (snapshot.data!.data.last.cashouts.isEmpty ||
                      !snapshot.hasData) {
                    return FutureBuilder(
                      future: IncomeServices().getAllDataIncome(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            snapshot.data!.isEmpty ||
                            !snapshot.hasData) {
                          return baseFinance("--", DataModel.empty());
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          final getPeriodeIncome =
                              snapshot.data!.last.createdAt;
                          return baseFinance(dateTimeFormat(getPeriodeIncome),
                              DataModel.empty());
                        }
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    final getPeriodeOutcome = snapshot.data!.data.last;
                    return baseFinance(
                        dateTimeFormat(
                            getPeriodeOutcome.cashouts.last.createdAt),
                        getPeriodeOutcome);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column baseStudents(
      dynamic totalSiswa, dynamic jmlhSiswaLaki, dynamic jmlhSiswaPr) {
    return Column(
      children: [
        // CONTAINER TOTAL SISWA
        AllDataStudentsUI(totalSiswa: totalSiswa),
        const SizedBox(height: 20),

        // CONTAINER JUMLAH SISWA BERDASARKAN JENIS KELAMIN
        SplitDataStudentsUI(
            jmlhSiswaLaki: jmlhSiswaLaki, jmlhSiswaPr: jmlhSiswaPr)
      ],
    );
  }

  // FUNCTION UNTUK MEMONITOR PERIODE KEUANGAN
  Column monitoredPeriode(String dataPeriode) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              "Periode: $dataPeriode",
              style: titleFonts,
            ),
          ),
        ),
      ],
    );
  }

  // FUNCTION UNTUK MEMONITOR DATA PEMASUKAN YANG DIINPUT
  FutureBuilder<Map<String, dynamic>> monitoredPemasukan(decadeId) {
    return FutureBuilder(
      future: TotalIncomeServices().getAllDataTotalIncomeByDecadeID(decadeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData ||
            snapshot.data == null) {
          return baseFinancePemasukan("0");
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          final getData = snapshot.data;
          return baseFinancePemasukan("${getData!["totalPemasukan"] ?? 0}");
        }
      },
    );
  }

  // FUNCTION UNTUK MEMONITOR DATA PENGELUARAN YANG DIINPUT
  FutureBuilder<Map<String, dynamic>> monitoredPengeluaran(decadeId) {
    return FutureBuilder(
      future: TotalOutcomeServices().getAllDataTotalOutcomeByDecadeId(decadeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData ||
            snapshot.data == null) {
          return baseFinancePengeluaran("0");
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          final getData = snapshot.data;
          return baseFinancePengeluaran("${getData!["totalPengeluaran"] ?? 0}");
        }
      },
    );
  }

  // BASE CONTAINER FINANCE
  Column baseFinance(String periodeFinance, DataModel getDataPeriode) {
    return Column(
      children: [
        // BASE CONTAINER PERIODE
        monitoredPeriode(periodeFinance),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Divider(
            color: Colors.black,
          ),
        ),

        // BASE CONTAINER FINANCE
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Kas",
                style: titleFonts,
              ),
              const SizedBox(
                height: 30,
              ),

              // BASE CONTAINER MENAMPILKAN TOTAL PEMASUKAN
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // BASE CONTAINER PEMASUKAN
                  FutureBuilder(
                    future: IncomeServices().getAllDataIncome(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          !snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return monitoredPemasukan(0);
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else {
                        final getDataDecadeId = snapshot.data!.last;
                        return monitoredPemasukan(getDataDecadeId.id);
                      }
                    },
                  ),
                  // BASE CONTAINER PENGELUARAN
                  monitoredPengeluaran(getDataPeriode.id)
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  // BASE CONTAINER TOTAL PEMASUKAN
  baseFinancePemasukan(String totalPemasukan) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 13,
                backgroundColor: Colors.green[700],
                child: const Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                  size: 19,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Pemasukan",
                style: boldComponentFonts,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 37),
            child: Text(
              formatCurrencyString(totalPemasukan),
              style: smallUniversalFonts,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // BASE CONTAINER TOTAL PEMASUKAN
  baseFinancePengeluaran(String totalPengeluaran) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 13,
                backgroundColor: Colors.red[700],
                child: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                  size: 19,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Pengeluaran",
                style: boldComponentFonts,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 37),
            child: Text(
              formatCurrencyString(
                  totalPengeluaran.isEmpty ? "0" : totalPengeluaran),
              style: smallUniversalFonts,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
