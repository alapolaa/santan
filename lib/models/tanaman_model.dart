import '../services/api_service.dart';


class Tanaman {
  final String id;
  final String nama;
  final String deskripsi;
  final String gambar;
  final String musim;

  Tanaman({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.gambar,
    required this.musim,
  });

  factory Tanaman.fromJson(Map<String, dynamic> json) {
    return Tanaman(
      id: json['id_tanaman'],
      nama: json['nama_tanaman'],
      deskripsi: json['deskripsi'],
      gambar: ApiService.baseUrl + json['gambar'],  // Menggunakan base URL dari ApiService
      musim: json['nama_musim'],
    );
  }
}
