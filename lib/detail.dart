import 'package:flutter/material.dart';
import 'package:santan/tanaman_model.dart';


class DetailScreen extends StatelessWidget {
  final Tanaman tanaman;

  DetailScreen({required this.tanaman});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tanaman.namaTanaman)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              "http://192.168.224.202/be_santan/${tanaman.gambar}",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, size: 100);
              },
            ),
            SizedBox(height: 16),
            Text(
              tanaman.namaTanaman,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Musim: ${tanaman.namaMusim}"),
            SizedBox(height: 16),
            Text(
              tanaman.deskripsi,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
