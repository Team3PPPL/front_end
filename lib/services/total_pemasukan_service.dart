import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pppl_apps/models/total_pemasukan_model.dart';

class TotalPemasukanService {
  final String universalUrl =
      "https://back-end-hazel-nine.vercel.app/total/pemasukan";

  Future<Map<String, dynamic>> getAllDataTotalPemasukan() async {
    final response = await http.get(Uri.parse(universalUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }
}
