import 'dart:convert';

class Tanaman {
  final String idTanaman;
  final String namaTanaman;
  final String deskripsi;
  final String gambar;
  final String namaMusim;

  Tanaman({
    required this.idTanaman,
    required this.namaTanaman,
    required this.deskripsi,
    required this.gambar,
    required this.namaMusim,
  });

  // Convert JSON ke Model
  factory Tanaman.fromJson(Map<String, dynamic> json) {
    return Tanaman(
      idTanaman: json['id_tanaman'],
      namaTanaman: json['nama_tanaman'],
      deskripsi: json['deskripsi'],
      gambar: json['gambar'],
      namaMusim: json['nama_musim'],
    );
  }

  // Convert Model ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id_tanaman': idTanaman,
      'nama_tanaman': namaTanaman,
      'deskripsi': deskripsi,
      'gambar': gambar,
      'nama_musim': namaMusim,
    };
  }

  // Helper untuk decode JSON string ke objek Tanaman
  static Tanaman fromJsonString(String jsonString) {
    return Tanaman.fromJson(jsonDecode(jsonString));
  }
}
