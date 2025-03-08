import 'package:flutter/material.dart';
import 'package:santan/tanaman_model.dart';
import 'api_service.dart';
import 'detail.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Tanaman yang sngat indah")),
      body: FutureBuilder<List<Tanaman>>(
        future: apiService.getTanaman(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Data tidak tersedia"));
          }

          List<Tanaman> tanamanList = snapshot.data!;

          return ListView.builder(
            itemCount: tanamanList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Image.network(
                    "http://192.168.224.202/be_santan/${tanamanList[index].gambar}",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image);
                    },
                  ),
                  title: Text(tanamanList[index].namaTanaman),
                  subtitle: Text("Musim: ${tanamanList[index].namaMusim}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(tanaman: tanamanList[index]),
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
