import 'package:flutter/material.dart';

import 'models/tanaman_service.dart';

class DetailTanamanScreen extends StatelessWidget {
  final Map<String, dynamic> tanaman;

  const DetailTanamanScreen({Key? key, required this.tanaman}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tanaman['nama_tanaman'])),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar
            Image.network(
              "${ApiService.baseUrl.replaceAll('/api', '')}/${tanaman['gambar']}",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Center(child: Text("Gambar tidak tersedia")),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tanaman['nama_tanaman'],
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  Text(
                    "Musim: ${tanaman['nama_musim']}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  SizedBox(height: 10),

                  Text(
                    "Deskripsi:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    tanaman['deskripsi'],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
