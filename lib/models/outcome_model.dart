class OutcomeModel {
  List<DataModel> data;

  OutcomeModel({
    required this.data,
  });

  factory OutcomeModel.fromJson(Map<String, dynamic> json) {
    List getDataList = json["data"];
    List<DataModel> listData =
        getDataList.map((x) => DataModel.fromJson(x)).toList();
    return OutcomeModel(
      data: listData,
    );
  }
}

class DataModel {
  int id;
  DateTime decade;
  List<CashoutModel> cashouts;

  DataModel({
    required this.id,
    required this.decade,
    required this.cashouts,
  });

  factory DataModel.empty() {
    return DataModel(id: 0, decade: DateTime.now(), cashouts: []);
  }

  factory DataModel.fromJson(Map<String, dynamic> json) {
    List getCashoutList = json["cashouts"];
    List<CashoutModel> listCashout =
        getCashoutList.map((x) => CashoutModel.fromJson(x)).toList();
    return DataModel(
        id: json["id"] ?? "Data tidak memiliki id",
        decade: DateTime.parse(
            json["decade"] ?? "Data tidak memiliki decade pengeluaran"),
        cashouts: listCashout);
  }
}

class CashoutModel {
  String jenisPengeluaran;
  int totalPengeluaran;
  DateTime createdAt;

  CashoutModel(
      {required this.jenisPengeluaran,
      required this.totalPengeluaran,
      required this.createdAt});

  factory CashoutModel.fromJson(Map<String, dynamic> json) {
    return CashoutModel(
      jenisPengeluaran:
          json["jenisPengeluaran"] ?? "Data tidak memiliki jenis pengeluaran",
      totalPengeluaran:
          json["totalPengeluaran"] ?? "Data tidak memiliki total pengeluaran",
      createdAt: DateTime.parse(
          json["createdAt"] ?? "Data tidak memiliki decade pengeluaran"),
    );
  }
}
