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

  factory Tanaman.fromJson(Map<String, dynamic> json) {
    return Tanaman(
      idTanaman: json['id_tanaman'],
      namaTanaman: json['nama_tanaman'],
      deskripsi: json['deskripsi'],
      gambar: json['gambar'],
      namaMusim: json['nama_musim'],
    );
  }
}
