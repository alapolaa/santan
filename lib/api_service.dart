import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:santan/tanaman_model.dart';


class ApiService {
  final String baseUrl = "http://192.168.224.202/be_santan/api/";

  Future<List<Tanaman>> getTanaman() async {
    try {
      final response = await http.get(Uri.parse("${baseUrl}get_tanaman.php"));

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => Tanaman.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
