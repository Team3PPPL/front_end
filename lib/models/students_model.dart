class StudentsModel {
  int totalSiswaCowok;
  int totalSiswaCewek;
  int totalKeseluruhan;

  StudentsModel(
      {required this.totalSiswaCowok,
      required this.totalSiswaCewek,
      required this.totalKeseluruhan});

  factory StudentsModel.fromJson(Map<String, dynamic> json) {
    return StudentsModel(
        totalSiswaCowok: json["totalSiswaCowok"] ?? "No Data",
        totalSiswaCewek: json["totalSiswaCewek"] ?? "No Data",
        totalKeseluruhan: json["totalKeseluruhan"] ?? "No Data");
  }
}
