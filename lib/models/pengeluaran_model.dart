class PengeluaranModel {
  int id;
  DateTime decade;
  Map<String, Cashout> cashouts;

  PengeluaranModel({
    required this.id,
    required this.decade,
    required this.cashouts,
  });

  factory PengeluaranModel.fromJson(Map<String, dynamic> json) {
    return PengeluaranModel(
      id: json["id"],
      decade: DateTime.parse(json["decade"]),
      cashouts: Map.from(json["cashouts"])
          .map((k, v) => MapEntry<String, Cashout>(k, Cashout.fromJson(v))),
    );
  }
}

class Cashout {
  int honorGuruMi;
  DateTime createdAt;
  int kontribusiYayasan;

  Cashout({
    required this.honorGuruMi,
    required this.createdAt,
    required this.kontribusiYayasan,
  });

  factory Cashout.fromJson(Map<String, dynamic> json) => Cashout(
        honorGuruMi: json["Honor Guru MI"] ?? 0,
        createdAt: DateTime.parse(json["createdAt"]),
        kontribusiYayasan: json["Kontribusi Yayasan"] ?? 0,
      );
}
// class PengeluaranModel {
//   int id;
//   int jenisPengeluaran;
//   DateTime tanggalPengeluaran;

//   PengeluaranModel(
//       {required this.id,
//       required this.jenisPengeluaran,
//       required this.tanggalPengeluaran});

//   factory PengeluaranModel.fromJson(Map<String, dynamic> json) {
//     return PengeluaranModel(
//         id: json["id"] ?? "Data tidak memiliki id",
//         jenisPengeluaran: json["Kontribusi Yayasan"] ??
//             json["Honor Guru MI"] ??
//             json["Honor Keamanan"] ??
//             json["Honor Kebersihan"] ??
//             json["Honor Pendamping"] ??
//             json["Komputer"] ??
//             json["Pramuka"] ??
//             json["Paskibra"] ??
//             json["Kaligrafi"] ??
//             json["Pencak Silat"] ??
//             json["Futsal & Sewa Lapangan"] ??
//             json["Qiro'at"] ??
//             json["Listrik / Telepon"] ??
//             json["Internet"] ??
//             json["Administrasi / ATK"] ??
//             json["Sarana dan Prasarana"] ??
//             json["PKG / PKM"] ??
//             json["Transport Dinas"] ??
//             json["Biaya Rapat"] ??
//             json["Konsumsi Guru"] ??
//             json["Langganan Sampah"] ??
//             json["Perbankan"] ??
//             json["Bos Buku"] ??
//             json["Operasional Bos + LPJ"] ??
//             json["BTT"] ??
//             "Pengguna tidak memilih salah satu jenis pengeluaran yang telah disediakan",
//         tanggalPengeluaran: DateTime.parse(
//             json["tanggalPengeluaran"] ?? DateTime.now().toIso8601String()));
//   }
// }
