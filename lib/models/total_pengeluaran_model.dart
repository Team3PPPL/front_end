class TotalPengeluaranModel {
  int totalPengeluaran;

  TotalPengeluaranModel({required this.totalPengeluaran});

  factory TotalPengeluaranModel.fromJson(Map<String, dynamic> json) {
    return TotalPengeluaranModel(totalPengeluaran: json["totalPengeluaran"]);
  }
}
