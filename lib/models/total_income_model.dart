class TotalIncomeModel {
  int totalPemasukan;

  TotalIncomeModel({required this.totalPemasukan});

  factory TotalIncomeModel.fromJson(Map<String, dynamic> json) {
    return TotalIncomeModel(
        totalPemasukan: json["totalPemasukan"] ??
            "Tidak ada total pemasukan untuk decade tersebut");
  }
}
