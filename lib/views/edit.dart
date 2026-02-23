import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:biodata/models/siswa.dart';
import 'package:biodata/models/api.dart';
import 'package:biodata/widgets/form.dart';

class Edit extends StatefulWidget {
  final SiswaModel sw;

  Edit({required this.sw});

  @override
  EditState createState() => EditState();
}

class EditState extends State<Edit> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nisController, namaController, tpLahirController,
      tgLahirController, kelaminController, agamaController, alamatController;

  Future editSiswa() async {
    return await http.post(
      Uri.parse(Api.update),
      body: {
        "id": widget.sw.id.toString(),
        "nis": nisController.text,
        "nama": namaController.text,
        "tp_lahir": tpLahirController.text,
        "tg_lahir": tgLahirController.text,
        "kelamin": kelaminController.text,
        "agama": agamaController.text,
        "alamat": alamatController.text,
      },
    );
  }

  pesan() {
    Fluttertoast.showToast(
      msg: "Perubahan Data Siswa Berhasil disimpan",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
  }

  void _onConfirm(context) async {
    http.Response response = await editSiswa();
    final data = json.decode(response.body);
    if (data['success'] == true) {
      pesan();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    nisController = TextEditingController(text: widget.sw.nis);
    namaController = TextEditingController(text: widget.sw.nama);
    tpLahirController = TextEditingController(text: widget.sw.tpLahir);
    tgLahirController = TextEditingController(text: widget.sw.tgLahir);
    kelaminController = TextEditingController(text: widget.sw.kelamin);
    agamaController = TextEditingController(text: widget.sw.agama);
    alamatController = TextEditingController(text: widget.sw.alamat);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Text("Update Data"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange,
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              _onConfirm(context);
            }
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
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
    );
  }
}