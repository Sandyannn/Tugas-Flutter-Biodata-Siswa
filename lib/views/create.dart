import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:biodata/models/siswa.dart';
import 'package:biodata/models/api.dart';
import 'package:biodata/widgets/form.dart';
import 'dart:async';

class Create extends StatefulWidget {
  @override
  CreateState createState() => CreateState();
}

class CreateState extends State<Create> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nisController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController tpLahirController = TextEditingController();
  TextEditingController tgLahirController = TextEditingController();
  TextEditingController kelaminController = TextEditingController();
  TextEditingController agamaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  Future createSiswa() async {
    try {
      return await http.post(
        Uri.parse(Api.create),
        body: {
          "nis": nisController.text,
          "nama": namaController.text,
          "tp_lahir": tpLahirController.text,
          "tg_lahir": tgLahirController.text,
          "kelamin": kelaminController.text,
          "agama": agamaController.text,
          "alamat": alamatController.text,
        },
      );
    } catch (e) {
      print("Error koneksi: $e");
      return null;
    }
  }

  void _onConfirm(context) async {
    http.Response? response = await createSiswa();

    if (response != null && response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      if (data['success'].toString() == "true") {
        print("Simpan Berhasil!");
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        print("Gagal Simpan: ${data['message']}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal menyimpan data!")),
        );
      }
    } else {
      print("Server Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            child: const Text("Simpan Siswa"),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                _onConfirm(context);
              }
            },
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: AppForm(
              formKey: formKey,
              nisController: nisController,
              namaController: namaController,
              tpLahirController: tpLahirController,
              tgLahirController: tgLahirController,
              kelaminController: kelaminController,
              agamaController: agamaController,
              alamatController: alamatController,
            ),
          ),
        ),
      ),
    );
  }
}