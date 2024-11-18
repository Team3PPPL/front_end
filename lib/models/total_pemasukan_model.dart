class TotalPemasukanModel {
  String totalAllIds;

  TotalPemasukanModel({required this.totalAllIds});

  factory TotalPemasukanModel.fromJson(Map<String, dynamic> json) {
    return TotalPemasukanModel(totalAllIds: json["totalAllIds"]);
  }
}
