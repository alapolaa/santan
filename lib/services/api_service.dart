import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tanaman_model.dart';

class ApiService {
  static const String baseUrl = "http://192.168.132.202/be_santan/";
  static const String imageUrl = "${baseUrl}images/";

  Future<List<Tanaman>> getTanaman() async {
    final response = await http.get(Uri.parse("${baseUrl}api/get_tanaman.php"));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Tanaman.fromJson(json)).toList();
    } else {
      throw Exception("Gagal mengambil data tanaman");
    }
  }
}
