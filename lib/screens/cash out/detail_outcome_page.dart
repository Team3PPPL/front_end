import 'package:flutter/material.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/models/pengeluaran_model.dart';

class DetailOutcomePage extends StatelessWidget {
  PengeluaranModel pengeluaranModel;
  DetailOutcomePage({super.key, required this.pengeluaranModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: componentColors,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Laporan Keuangan",
                  style: titleFonts,
                ),
              ),
              Text("Periode")
            ],
          )
        ],
      ),
    );
  }
}
