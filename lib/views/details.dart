import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:biodata/models/api.dart';
import 'package:biodata/models/siswa.dart';
import 'package:biodata/views/edit.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class Details extends StatefulWidget {
  final SiswaModel sw;
  Details({required this.sw});

  @override
  DetailsState createState() => DetailsState();
}

class DetailsState extends State<Details> {
  void deleteSiswa(context) async {
    http.Response response = await http.post(
      Uri.parse(Api.delete),
      body: {
        'id': widget.sw.id.toString(),
      },
    );
    final data = json.decode(response.body);
    if (data['success'] == true) {
      pesan();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  pesan() {
    Fluttertoast.showToast(
        msg: "Data siswa berhasil dihapus",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void confirmDelete(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
                'Apakah anda yakin akan menghapus siswa ${widget.sw.nama}?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(Icons.cancel),
              ),
              ElevatedButton(
                onPressed: () => deleteSiswa(context),
                child: Icon(Icons.check_circle),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.blue[100],
              child: Icon(
                Icons.person,
                size: 150,
                color: Colors.blue[300],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.sw.nama,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "NIS: ${widget.sw.nis}",
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  const Divider(height: 30),
                  const Text("Tempat Lahir:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.sw.tpLahir,
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  const Text("Tanggal Lahir:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.sw.tgLahir,
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  const Text("Jenis Kelamin:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.sw.kelamin,
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  const Text("Agama:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.sw.agama,
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  const Text("Alamat:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.sw.alamat,
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Edit(sw: widget.sw),
          ),
        ),
      ),
    );
  }
}