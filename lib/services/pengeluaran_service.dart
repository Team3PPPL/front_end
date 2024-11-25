import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pppl_apps/models/pengeluaran_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PengeluaranServices {
  final String universalUrl =
      "https://back-end-hazel-nine.vercel.app/pengeluaran";

  // FUNCTION UNTUK MENGAMBIL SELURUH DATA
  Future<List<PengeluaranModel>> getAllDataPengeluaran() async {
    final response = await http.get(Uri.parse(universalUrl));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final listData = responseBody['data'] as List;
      final result = listData.map((e) => PengeluaranModel.fromJson(e)).toList();
      return result;
    } else {
      throw Exception("Failed to load data");
    }
  }

  // FUNCTION UNTUK MENGAMBIL SELURUH DATA BERDASARKAN DEKADE PENGELUARAN
  Future<List<PengeluaranModel>> getAllDataDecadePengeluaran(
      int decadeId) async {
    final response = await http.get(Uri.parse("$universalUrl/$decadeId"));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final listData = responseBody['data'] as List;
      final result = listData.map((e) => PengeluaranModel.fromJson(e)).toList();
      return result;
    } else {
      throw Exception("Failed to load data");
    }
  }

  // FUNCTION UNTUK MEMASUKKAN DATA DECADE BARU
  // Future<PengeluaranModel> addNewDataPengeluaran(
  //     jenisPengeluaran, DateTime tanggalPemasukan) async {
  //   Map<String, dynamic> requestData = {
  //     "jenisPengeluaran": jenisPengeluaran,
  //     "tanggalPemasukan": tanggalPemasukan.toIso8601String()
  //   };

  //   try {
  //     final response = await http.post(
  //       Uri.parse("$universalUrl/input"),
  //       headers: {"Content-Type": "application/json"},
  //       body: json.encode(requestData),
  //     );

  //     if (response.statusCode == 200) {
  //       print("Berhasil menambahkan data baru");
  //       return PengeluaranModel.fromJson(json.decode(response.body));
  //     } else {
  //       print("Failed to post data: ${response.statusCode}");
  //       print("Response body: ${response.body}");
  //       throw Exception("Failed to post data");
  //     }
  //   } catch (e) {
  //     throw Exception("Failed to add new data");
  //   }
  // }

  // FUNCTION UNTUK MENGUPDATE DATA
  // Future<PengeluaranModel> updateData(
  //     int id,
  //     int bos,
  //     int kelas1,
  //     int kelas2,
  //     int kelas3,
  //     int kelas4,
  //     int kelas5,
  //     int kelas6,
  //     DateTime tanggalPemasukan) async {
  //   Map<String, dynamic> requestData = {
  //     "bos": bos,
  //     "kelas1": kelas1,
  //     "kelas2": kelas2,
  //     "kelas3": kelas3,
  //     "kelas4": kelas4,
  //     "kelas5": kelas5,
  //     "kelas6": kelas6,
  //     'tanggalPemasukan': tanggalPemasukan.toIso8601String()
  //   };

  //   final response = await http.put(
  //     Uri.parse("$universalUrl/$id"),
  //     headers: {"Content-Type": "application/json"},
  //     body: json.encode(requestData),
  //   );

  //   if (response.statusCode == 200) {
  //     return PengeluaranModel.fromJson(json.decode(response.body));
  //   } else {
  //     print("Failed to update data: ${response.statusCode}");
  //     print("Response body: ${response.body}");
  //     throw Exception("Failed to update data");
  //   }
  // }

  // FUNCTION UNTUK MENGHAPUS SELURUH DATA YANG ADA PADA PERIODE TERTENTU
  Future<void> deleteAllDataPengeluaranInDecade(int decadeId) async {
    final response = await http.delete(
      Uri.parse("$universalUrl/delete/$decadeId"),
    );
    if (response.statusCode == 200) {
      print("Data dengan id $decadeId berhasil dihapus");
    } else {
      print("Failed to delete data: ${response.statusCode}");
      throw Exception("Failed to delete data");
    }
  }

  // FUNCTION UNTUK MENGHAPUS SALAH SATU DATA YANG TERSIMPAN DALAM DEKADE YANG DIPILIH
  Future<void> deleteDataPengeluaranInDecade(
      int decadeId, int cashOutId) async {
    final response = await http.delete(
      Uri.parse("$universalUrl/delete/$decadeId/cashout/$cashOutId"),
    );
    if (response.statusCode == 200) {
      print("Data dengan id $decadeId berhasil dihapus");
    } else {
      print("Failed to delete data: ${response.statusCode}");
      throw Exception("Failed to delete data");
    }
  }

  // FUNCTION UNTUK MENGHAPUS SALAH SATU DATA YANG TERSIMPAN DALAM DEKADE YANG DIPILIH
  Future<void> updateDataPengeluaranInDecade(
      int decadeId, int cashOutId) async {
    final response = await http.delete(
      Uri.parse("$universalUrl/update/$decadeId/cashout/$cashOutId"),
    );
    if (response.statusCode == 200) {
      print("Data dengan id $decadeId berhasil diupdate");
    } else {
      print("Failed to update data: ${response.statusCode}");
      throw Exception("Failed to update data");
    }
  }

  // FUNCTION UNTUK PRINT HASIL PENGELUARAN DALAM BENTUK PDF
  Future printData(int decadeId) async {
    final pdfUrl = "$universalUrl/$decadeId/cashout/pdf";
    final response = await http.get(Uri.parse(pdfUrl));

    if (response.statusCode == 200) {
      await launchUrl(Uri.parse(pdfUrl));
      print("$decadeId");
    } else {
      print("Failed to direct data: ${response.statusCode}");
      throw Exception("Failed to direct data");
    }
  }

  deleteDataPengeluaran(int id) {}
}
