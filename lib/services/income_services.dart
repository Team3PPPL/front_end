import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pppl_apps/models/income_model.dart';
import 'package:url_launcher/url_launcher.dart';

class IncomeServices {
  final String universalUrl =
      "https://back-end-hazel-nine.vercel.app/pemasukan";

  // FUNCTION UNTUK MENGAMBIL SELURUH DATA
  Future<List<IncomeModel>> getAllDataIncome() async {
    final response = await http.get(Uri.parse(universalUrl));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final listData = responseBody['data'] as List;
      final result = listData.map((e) => IncomeModel.fromJson(e)).toList();
      return result;
    } else {
      throw Exception("Failed to load data");
    }
  }

  // FUNCTION UNTUK MEMASUKKAN DATA BARU
  Future addNewDataIncome(int bos, int kelas1, int kelas2, int kelas3,
      int kelas4, int kelas5, int kelas6, DateTime tanggalPemasukan) async {
    Map<String, dynamic> requestData = {
      "bos": bos,
      "kelas1": kelas1,
      "kelas2": kelas2,
      "kelas3": kelas3,
      "kelas4": kelas4,
      "kelas5": kelas5,
      "kelas6": kelas6,
      "tanggalPemasukan": tanggalPemasukan.toIso8601String()
    };
    try {
      final response = await http.post(
        Uri.parse("$universalUrl/input"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestData),
      );
      if (response.statusCode == 200 && requestData.isNotEmpty) {
        print("Response: ${response.statusCode}");
        print("Data: ${response.body}");
        print("Berhasil menambahkan data baru");
        return response.body;
        // return IncomeModel.fromJson(json.decode(response.body));
      } else {
        print("Response: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to post data");
      }
    } catch (e) {
      rethrow;
    }
  }

  // FUNCTION UNTUK MENGUPDATE DATA
  Future updateDataIncome(int id, int bos, int kelas1, int kelas2, int kelas3,
      int kelas4, int kelas5, int kelas6, DateTime tanggalPemasukan) async {
    Map<String, dynamic> requestData = {
      "bos": bos,
      "kelas1": kelas1,
      "kelas2": kelas2,
      "kelas3": kelas3,
      "kelas4": kelas4,
      "kelas5": kelas5,
      "kelas6": kelas6,
      'tanggalPemasukan': tanggalPemasukan.toIso8601String()
    };
    try {
      final response = await http.put(
        Uri.parse("$universalUrl/update/$id"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestData),
      );
      if (response.statusCode == 200) {
        print("Response: ${response.statusCode}");
        print("Data dengan id $id berhasil diupdate");
        return response.body;
      } else {
        print("Response: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to update data");
      }
    } catch (e) {
      rethrow;
    }
  }

  // FUNCTION UNTUK MENGHAPUS DATA
  Future<void> deleteDataIncomeById(int id) async {
    final response = await http.delete(
      Uri.parse("$universalUrl/delete/$id"),
    );
    if (response.statusCode == 200) {
      print("Response: ${response.statusCode}");
      print("Data dengan id $id berhasil dihapus");
    } else {
      print("Response: ${response.statusCode}");
      throw Exception("Failed to delete data");
    }
  }

  // FUNCTION UNTUK PRINT HASIL PEMASUKAN DALAM BENTUK PDF
  Future printDataIncomeById(int id) async {
    final pdfUrl = "$universalUrl/$id/pdf";
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
