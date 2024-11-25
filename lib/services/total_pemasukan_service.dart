import 'dart:convert';
import 'package:http/http.dart' as http;

class TotalPemasukanService {
  final String universalUrl =
      "https://back-end-hazel-nine.vercel.app/total/pemasukan";

  // FUNCTION UNTUK MENDAPATKAN SELURUH TOTAL PEMASUKAN
  Future<Map<String, dynamic>> getAllDataTotalPemasukan() async {
    final response = await http.get(Uri.parse(universalUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }

  // FUNCTION UNTUK MENDAPATKAN TOTAL PEMASUKAN BERDASARKAN PERIODE
  Future<Map<String, dynamic>> getAllDataTotalPemasukanInDecade(
      int decadeId) async {
    final response = await http.get(Uri.parse("$universalUrl/$decadeId"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }
}
