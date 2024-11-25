class TotalPemasukanModel {
  int totalPemasukan;

  TotalPemasukanModel({required this.totalPemasukan});

  factory TotalPemasukanModel.fromJson(Map<String, dynamic> json) {
    return TotalPemasukanModel(totalPemasukan: json["totalPemasukan"]);
  }
}
