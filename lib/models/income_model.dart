class IncomeModel {
  int id;
  int bos;
  int kelas1;
  int kelas2;
  int kelas3;
  int kelas4;
  int kelas5;
  int kelas6;
  DateTime tanggalPemasukan;

  IncomeModel(
      {required this.id,
      required this.bos,
      required this.kelas1,
      required this.kelas2,
      required this.kelas3,
      required this.kelas4,
      required this.kelas5,
      required this.kelas6,
      required this.tanggalPemasukan});

  factory IncomeModel.fromJson(Map<String, dynamic> json) {
    return IncomeModel(
        id: json["id"] ?? "Data tidak memiliki id",
        bos: json["bos"] ?? "Data tidak memiliki nilai pemasukan dana bos",
        kelas1: json["kelas1"] ??
            "Data tidak memiliki nilai pemasukan untuk kelas 1",
        kelas2: json["kelas2"] ??
            "Data tidak memiliki nilai pemasukan untuk kelas 2",
        kelas3: json["kelas3"] ??
            "Data tidak memiliki nilai pemasukan untuk kelas 3",
        kelas4: json["kelas4"] ??
            "Data tidak memiliki nilai pemasukan untuk kelas 4",
        kelas5: json["kelas5"] ??
            "Data tidak memiliki nilai pemasukan untuk kelas 5",
        kelas6: json["kelas6"] ??
            "Data tidak memiliki nilai pemasukan untuk kelas 6",
        tanggalPemasukan: DateTime.parse(
            json["tanggalPemasukan"] ?? DateTime.now().toIso8601String()));
  }
}
