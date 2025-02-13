import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.110.202/be_santan/api';

  Future<List<dynamic>> getTanaman() async {
    final response = await http.get(Uri.parse('$baseUrl/get_tanaman.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      // Tampilkan JSON di console
      print(jsonEncode(data));

      return data;
    } else {
      throw Exception('Gagal mengambil data');
    }
  }
}

