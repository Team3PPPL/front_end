import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pppl_apps/models/students_model.dart';

class StudentsServices {
  String universalUrl =
      "https://back-end-hazel-nine.vercel.app/siswa/total/siswa";

  // FUNCTION UNTUK MENDAPATKAN SELURUH DATA SISWA
  Future<StudentsModel> getAllDataStudent() async {
    final response = await http.get(Uri.parse(universalUrl));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final dataSurah = responseBody['data'];
      return StudentsModel.fromJson(dataSurah);
    } else {
      throw Exception("Failed to load data");
    }
  }
}
