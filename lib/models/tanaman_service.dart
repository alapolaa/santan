import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.110.202/be_santan/api';

  Future<List<dynamic>> getTanaman() async {
    final response = await http.get(Uri.parse('$baseUrl/get_tanaman.php'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  Future<Map<String, dynamic>> addTanaman({
    required String nama,
    required String deskripsi,
    required String idMusim,
    File? gambar, // File gambar opsional
  }) async {
    var uri = Uri.parse('$baseUrl/add_tanaman.php');
    var request = http.MultipartRequest('POST', uri);

    request.fields['nama_tanaman'] = nama;
    request.fields['deskripsi'] = deskripsi;
    request.fields['id_musim'] = idMusim;

    if (gambar != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'gambar',
        gambar.path,
        filename: basename(gambar.path), // Ambil nama file
      ));
    }

    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return json.decode(responseData);
    } else {
      throw Exception('Gagal menambahkan data');
    }
  }
}
