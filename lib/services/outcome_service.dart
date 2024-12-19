import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pppl_apps/models/outcome_model.dart';
import 'package:url_launcher/url_launcher.dart';

class OutcomeServices {
  final String universalUrl =
      "https://back-end-hazel-nine.vercel.app/pengeluaran";

  // FUNCTION UNTUK MENGAMBIL SELURUH DATA
  Future<OutcomeModel> getAllDataOutcome() async {
    final response = await http.get(Uri.parse(universalUrl));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final listData = responseBody;
      // final result = listData.map((e) => OutcomeModel.fromJson(e)).toList();
      // return result;
      return OutcomeModel.fromJson(listData);
    } else {
      throw Exception("Failed to load data");
    }
  }

  // FUNCTION UNTUK MENGAMBIL SELURUH DATA YANG TERSIMPAN DI DALAM DEKADE TERTENTU
  Future<DataModel> getAllDataOutcomeByDecadeId(int decadeId) async {
    final response = await http.get(Uri.parse("$universalUrl/$decadeId"));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final listData = responseBody['data'];
      return DataModel.fromJson(listData);
    } else {
      throw Exception("Failed to load data by decade");
    }
  }

  // FUNCTION UNTUK MENGAMBIL SALAH SATU DATA YANG ADA PADA DECADE TERTENTU
  Future<CashoutModel> getDataInDecade(
      int decadeId, String jenisPengeluaran) async {
    final response = await http
        .get(Uri.parse("$universalUrl/$decadeId/cashout/$jenisPengeluaran"));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final listData = responseBody['data'];
      return CashoutModel.fromJson(listData);
    } else {
      throw Exception("Failed to load data in decade $decadeId");
    }
  }

  // FUNCTION UNTUK MEMASUKKAN DATA DEKADE BARU
  Future addNewDecadeOutcome(DateTime decade) async {
    Map<String, dynamic> requestData = {"decade": decade.toIso8601String()};
    try {
      final response = await http.post(
        Uri.parse("$universalUrl/input/decade"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        print("Response: ${response.statusCode}");
        print("Data: ${response.body}");
        print("Berhasil menambahkan data baru");
        return response.body;
      } else {
        print("Response: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to post data");
      }
    } catch (e) {
      rethrow;
    }
  }

  // FUNCTION UNTUK MEMASUKKAN DATA JENIS PENGELUARAN BARU
  Future addNewDataOutcome(
      int decadeId, String jenisPengeluaran, int totalPengeluaran) async {
    Map<String, dynamic> requestData = {jenisPengeluaran: totalPengeluaran};
    try {
      final response = await http.post(
        Uri.parse("$universalUrl/input/$decadeId/cashout"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestData),
      );
      if (response.statusCode == 200) {
        print("Response: ${response.statusCode}");
        print("Data: ${response.body}");
        print("Berhasil menambahkan data baru");
        return response.body;
        // return CashoutModel.fromJson(json.decode(response.body));
      } else {
        print("Response: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to post data");
      }
    } catch (e) {
      rethrow;
    }
  }

  // FUNCTION UNTUK MENGUPDATE SALAH SATU DATA YANG TERSIMPAN DALAM DEKADE YANG DIPILIH
  Future updateDataPengeluaranInDecade(
      int decadeId, String jenisPengeluaran, int totalPengeluaran) async {
    Map<String, dynamic> requestData = {"totalPengeluaran": totalPengeluaran};
    final response = await http.put(
      Uri.parse("$universalUrl/update/$decadeId/cashout/$jenisPengeluaran"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(requestData),
    );
    if (response.statusCode == 200) {
      print("Response: ${response.statusCode}");
      print("Data dengan id $decadeId berhasil diupdate");
      return response.body;
    } else {
      print("Response: ${response.statusCode}");
      print("Response body: ${response.body}");
      throw Exception("Failed to update data");
    }
  }

  // FUNCTION UNTUK MENGHAPUS SELURUH DATA YANG ADA PADA PERIODE DEKADE TERTENTU
  Future<void> deleteAllDataOutcomeByDecadeId(int decadeId) async {
    final response = await http.delete(
      Uri.parse("$universalUrl/delete/$decadeId"),
    );
    if (response.statusCode == 200) {
      print("Response: ${response.statusCode}");
      print("Data dengan id $decadeId berhasil dihapus");
    } else {
      print("Response: ${response.statusCode}");
      throw Exception("Failed to delete data");
    }
  }

  // FUNCTION UNTUK MENGHAPUS SALAH SATU DATA YANG TERSIMPAN DALAM DEKADE YANG DIPILIH
  Future<void> deleteDataOutcomeByType(
      int decadeId, String jenisPengeluaran) async {
    final response = await http.delete(
      Uri.parse("$universalUrl/delete/$decadeId/cashout/$jenisPengeluaran"),
    );
    if (response.statusCode == 200) {
      print("Response: ${response.statusCode}");
      print(
          "Data $jenisPengeluaran dari decade id ke-$decadeId berhasil dihapus");
    } else {
      print("Response: ${response.statusCode}");

      throw Exception("Failed to delete data");
    }
  }

  // FUNCTION UNTUK PRINT HASIL PENGELUARAN DALAM BENTUK PDF
  Future printDataOutcomeByDecadeId(int decadeId) async {
    final pdfUrl = "$universalUrl/$decadeId/pdf";
    final response = await http.get(Uri.parse(pdfUrl));
    if (response.statusCode == 200) {
      print("Response: ${response.statusCode}");
      await launchUrl(Uri.parse(pdfUrl));
    } else {
      print("Response: ${response.statusCode}");

      throw Exception("Failed to direct data");
    }
  }
}
