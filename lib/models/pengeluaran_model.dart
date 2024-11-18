class PengeluaranModel {
  int id;
  int jenisPengeluaran;
  DateTime tanggalPengeluaran;

  PengeluaranModel(
      {required this.id,
      required this.jenisPengeluaran,
      required this.tanggalPengeluaran});

  factory PengeluaranModel.fromJson(Map<String, dynamic> json) {
    return PengeluaranModel(
        id: json["id"] ?? "Data tidak memiliki id",
        jenisPengeluaran: json["Kontribusi Yayasan"] ??
            json["Honor Guru MI"] ??
            json["Honor Keamanan"] ??
            json["Honor Kebersihan"] ??
            json["Honor Pendamping"] ??
            json["Komputer"] ??
            json["Pramuka"] ??
            json["Paskibra"] ??
            json["Kaligrafi"] ??
            json["Pencak Silat"] ??
            json["Futsal & Sewa Lapangan"] ??
            json["Qiro'at"] ??
            json["Listrik / Telepon"] ??
            json["Internet"] ??
            json["Administrasi / ATK"] ??
            json["Sarana dan Prasarana"] ??
            json["PKG / PKM"] ??
            json["Transport Dinas"] ??
            json["Biaya Rapat"] ??
            json["Konsumsi Guru"] ??
            json["Langganan Sampah"] ??
            json["Perbankan"] ??
            json["Bos Buku"] ??
            json["Operasional Bos + LPJ"] ??
            json["BTT"] ??
            "Pengguna tidak memilih salah satu jenis pengeluaran yang telah disediakan",
        tanggalPengeluaran: DateTime.parse(
            json["tanggalPengeluaran"] ?? DateTime.now().toIso8601String()));
  }
}
