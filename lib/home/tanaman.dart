import 'package:flutter/material.dart';
import 'package:santan/services/api_service.dart';

import '../models/tanaman_model.dart';


class TanamanPage extends StatefulWidget {
  @override
  _TanamanPageState createState() => _TanamanPageState();
}

class _TanamanPageState extends State<TanamanPage> {
  late Future<List<Tanaman>> futureTanaman;

  @override
  void initState() {
    super.initState();
    futureTanaman = ApiService().getTanaman();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Tanaman"),
      ),
      body: FutureBuilder<List<Tanaman>>(
        future: futureTanaman,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Terjadi kesalahan!"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada data tanaman"));
          }

          List<Tanaman> tanamanList = snapshot.data!;

          return ListView.builder(
            itemCount: tanamanList.length,
            itemBuilder: (context, index) {
              Tanaman tanaman = tanamanList[index];
              return Card(
                child: ListTile(
                  leading: Image.network(tanaman.gambar, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(tanaman.nama),
                  subtitle: Text(tanaman.musim),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(tanaman.nama),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(tanaman.gambar),
                            SizedBox(height: 10),
                            Text(tanaman.deskripsi),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Tutup"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
