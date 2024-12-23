class IncomeModel {
  late int id;
  late int bos;
  late int kelas1;
  late int kelas2;
  late int kelas3;
  late int kelas4;
  late int kelas5;
  late int kelas6;
  DateTime tanggalPemasukan;
  DateTime createdAt;

  IncomeModel(
      {required this.id,
      required this.bos,
      required this.kelas1,
      required this.kelas2,
      required this.kelas3,
      required this.kelas4,
      required this.kelas5,
      required this.kelas6,
      required this.tanggalPemasukan,
      required this.createdAt});

  factory IncomeModel.fromJson(Map<String, dynamic> json) {
    return IncomeModel(
      id: json["id"] ?? "Data tidak memiliki id",
      bos: json["bos"] ?? 0,
      kelas1: json["kelas1"] ?? 0,
      kelas2: json["kelas2"] ?? 0,
      kelas3: json["kelas3"] ?? 0,
      kelas4: json["kelas4"] ?? 0,
      kelas5: json["kelas5"] ?? 0,
      kelas6: json["kelas6"] ?? 0,
      tanggalPemasukan: DateTime.parse(
          json["tanggalPemasukan"] ?? DateTime.now().toIso8601String()),
      createdAt: DateTime.parse(
          json["createdAt"] ?? "Data tidak memiliki decade pengeluaran"),
    );
  }
}
