class TotalOutcomeModel {
  int totalPengeluaran;

  TotalOutcomeModel({required this.totalPengeluaran});

  factory TotalOutcomeModel.fromJson(Map<String, dynamic> json) {
    return TotalOutcomeModel(
        totalPengeluaran: json["totalPengeluaran"] ??
            "Tidak ada total pengeluaran untuk decade tersebut");
  }
}
