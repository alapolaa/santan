import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import 'models/tanaman_service.dart'; // Sesuaikan nama proyek

class AddTanamanPage extends StatefulWidget {
  @override
  _AddTanamanPageState createState() => _AddTanamanPageState();
}

class _AddTanamanPageState extends State<AddTanamanPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  String? _selectedMusim;
  File? _image;
  final picker = ImagePicker();
  final ApiService apiService = ApiService();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitData() async {
    if (_namaController.text.isEmpty ||
        _deskripsiController.text.isEmpty ||
        _selectedMusim == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap isi semua data')),
      );
      return;
    }

    try {
      var response = await apiService.addTanaman(
        nama: _namaController.text,
        deskripsi: _deskripsiController.text,
        idMusim: _selectedMusim!,
        gambar: _image,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );

      if (response['status'] == 'success') {
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Tanaman')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama Tanaman'),
            ),
            TextField(
              controller: _deskripsiController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedMusim,
              onChanged: (value) {
                setState(() {
                  _selectedMusim = value;
                });
              },
              items: ['1', '2', '3']
                  .map((e) => DropdownMenuItem(value: e, child: Text('Musim $e')))
                  .toList(),
              decoration: InputDecoration(labelText: 'Pilih Musim'),
            ),
            SizedBox(height: 10),
            _image == null
                ? Text('Belum ada gambar')
                : Image.file(_image!, height: 100),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pilih Gambar'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
