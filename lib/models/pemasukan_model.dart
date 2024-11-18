class PemasukanModel {
  int id;
  int bos;
  int kelas1;
  int kelas2;
  int kelas3;
  int kelas4;
  int kelas5;
  int kelas6;
  DateTime tanggalPemasukan;

  PemasukanModel(
      {required this.id,
      required this.bos,
      required this.kelas1,
      required this.kelas2,
      required this.kelas3,
      required this.kelas4,
      required this.kelas5,
      required this.kelas6,
      required this.tanggalPemasukan});

  factory PemasukanModel.fromJson(Map<String, dynamic> json) {
    return PemasukanModel(
        id: json["id"] ?? "Data tidak memiliki id",
        bos: json["bos"] ?? "Data tidak memiliki pemasukan dana bos",
        kelas1: json["kelas1"] ?? "Data tidak memiliki pemasukan kelas 1",
        kelas2: json["kelas2"] ?? "Data tidak memiliki pemasukan kelas 2",
        kelas3: json["kelas3"] ?? "Data tidak memiliki pemasukan kelas 3",
        kelas4: json["kelas4"] ?? "Data tidak memiliki pemasukan kelas 4",
        kelas5: json["kelas5"] ?? "Data tidak memiliki pemasukan kelas 5",
        kelas6: json["kelas6"] ?? "Data tidak memiliki pemasukan kelas 6",
        tanggalPemasukan: DateTime.parse(
            json["tanggalPemasukan"] ?? DateTime.now().toIso8601String()));
  }
}
