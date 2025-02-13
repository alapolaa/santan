

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/tanaman_service.dart';

class TanamanScreen extends StatefulWidget {
  @override
  _TanamanScreenState createState() => _TanamanScreenState();
}

class _TanamanScreenState extends State<TanamanScreen> {
  late Future<List<dynamic>> tanamanFuture;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    tanamanFuture = apiService.getTanaman();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data Tanaman")),
      body: FutureBuilder<List<dynamic>>(
        future: tanamanFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Gagal memuat data"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada data"));
          }

          List<dynamic> tanamanList = snapshot.data!;

          return ListView.builder(
            itemCount: tanamanList.length,
            itemBuilder: (context, index) {
              var tanaman = tanamanList[index];
              return Card(
                margin: EdgeInsets.all(10),
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
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama Tanaman
                          Text(
                            tanaman['nama_tanaman'],
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          // Deskripsi
                          Text(tanaman['deskripsi'], maxLines: 3, overflow: TextOverflow.ellipsis),
                          SizedBox(height: 5),
                          // Nama Musim
                          Text(
                            "Musim: ${tanaman['nama_musim']}",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}