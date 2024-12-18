import 'dart:convert';
import 'package:http/http.dart' as http;

class TotalOutcomeServices {
  final String universalUrl =
      "https://back-end-hazel-nine.vercel.app/total/pengeluaran";

  // FUNCTION UNTUK MENDAPATKAN SELURUH TOTAL PENGELUARAN
  Future<Map<String, dynamic>> getAllDataTotalOutcome() async {
    final response = await http.get(Uri.parse(universalUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }

  // FUNCTION UNTUK MENDAPATKAN TOTAL PENGELUARAN BERDASARKAN PERIODE
  Future<Map<String, dynamic>> getAllDataTotalOutcomeByDecadeId(
      int decadeId) async {
    final response = await http.get(Uri.parse("$universalUrl/$decadeId"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }
}
